defmodule WebsiteWeb.WritingLive do
  use WebsiteWeb, :live_view

  alias Website.Writing
  alias Website.Writing.Post

  @impl true
  def render(%{post: nil} = assigns) do
    ~H"""
    <div>
      <.breadcrumbs folders={[%{name: "home", path: ~p"/"}]} h1="writing" />

      <div class="mt-10 flex flex-wrap gap-10">
        <.blog_post_card
          :for={post <- @posts}
          id={post.id}
          navigate={~p"/writing/#{post}"}
          title={post.title}
          img_url={post.picture_url}
          class="w-full max-w-[25rem]"
        />
      </div>
    </div>
    """
  end

  def render(%{post: %Post{}} = assigns) do
    ~H"""
    <div>
      <.breadcrumbs
        folders={[%{name: "home", path: ~p"/"}, %{name: "writing", path: ~p"/writing"}]}
        h1={@post.title}
      />

      <div class="mt-10 max-w-2xl blogpost"><%= raw(@post.body) %></div>
    </div>
    """
  end

  ### Server

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply,
     socket
     |> apply_action(socket.assigns.live_action, params)
     |> assign_page_meta()}
  end

  ### Helpers

  defp apply_action(socket, :index, _params) do
    assign(socket, post: nil, posts: Writing.all_posts())
  end

  defp apply_action(socket, :show, %{"id" => post_id} = _params) do
    assign(socket, post: Writing.get_post_by_id!(post_id))
  end

  # NOTE: Check rendering with https://socialsharepreview.com
  defp assign_page_meta(%{assigns: %{post: nil}} = socket) do
    assign(socket,
      page_title: "Writing"
      # page_description: ""
    )
  end

  defp assign_page_meta(%{assigns: %{post: post}} = socket) do
    assign(socket,
      page_title: post.title,
      page_description: post.description,
      page_image: post.picture_url,
      page_twitter_card: "summary_large_image",
      page_data: [
        %{
          label: "Reading time",
          value:
            post.body
            |> String.split(~r/\s/)
            |> length()
            # NOTE: Average reading time is 200 words/minute
            |> div(200)
            |> case do
              0 -> "less than 1 minute"
              1 -> "1 minute"
              x -> "#{x} minutes"
            end
        },
        %{label: "Date", value: post.date}
      ]
    )
  end
end
