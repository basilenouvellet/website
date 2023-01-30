%{
title: "Client-side relative time UI component with Phoenix LiveView",
description: "Showing relative time between now and a given moment in time can be tricky",
picture_url: "/images/relative_time.webp"
}

---

![relative time illustration](/images/relative_time.webp)

The other day, I needed to build a Github-like timeline, displaying events sorted by timestamp.
The idea was to display those timestamps not in their absolute form, but relatively:
`2 minutes ago` instead of `2023-01-26T10:00:00Z`.

The thing is that those events could have just happened `10 seconds ago`, so I needed the time display to **update
in real-time, without refreshing the page**.

As you probably already know, LiveView is good at real-time HTML updates.
Let's see how to build a UI component for this task.

## Naive approach: server-side using Live Component

The first idea that comes to mind is to build a live component, updating its state every second.

```elixir
defmodule RelativeTime do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
    <p class="my-16"><%= @relative_time %> seconds ago</p>
    """
  end

  def update(assigns, socket) do
    schedule_tick(assigns)

    {:ok, assign(socket, relative_time: to_relative_time(assigns.timestamp))}
  end

  defp schedule_tick(assigns) do
    Process.send_after(self(), {:tick, assigns}, :timer.seconds(1))
  end

  defp to_relative_time(timestamp) do
    {:ok, dt, _} = DateTime.from_iso8601(timestamp)
    DateTime.diff(DateTime.utc_now(), dt, :second)
  end
end
```

To trigger the state update, we send a process message `{:tick, assigns}` to the current process `self()`.

> Live components are not processes, only liveviews are. That's why here `self()` refers to the liveview process.

When the liveview receives the message, it triggers a component update with [`send_update/3`](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html#send_update/3).

```elixir
defmodule MyLiveView do
  use Phoenix.LiveView

  def render(assigns) do
  ~H"""
  <div>
    <h1>Relative time</h1>

    <.live_component
      module={RelativeTime}
      id="relative-time"
      timestamp="2023-01-26T13:40:00Z"
    />
  </div>
  """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_info({:tick, assigns}, socket) do
    send_update(RelativeTime, assigns)
    {:noreply, socket}
  end
end
```

This works but there is a major issue with this solution: in bad network conditions,
the delay to send the updated relative time would be noticeable, causing the timer to drift.

We can verify this by simulating latency in our liveview socket:

[GIF HERE SIMULATING LATENCY WITH TIMER]
