defmodule WebsiteWeb.HomeLive do
  use WebsiteWeb, :live_view

  alias Website.Writing

  @impl true
  def render(assigns) do
    ~H"""
    <div class={[
      "fixed inset-y-0 right-0 left-[42rem] hidden lg:block xl:left-[52rem]",
      "bg-[url('/images/illustration.webp')] bg-cover bg-no-repeat"
    ]} />

    <div class="py-10 px-4 sm:py-12 sm:px-12 xl:py-12 xl:px-20">
      <div class="lg:max-w-xl xl:max-w-2xl">
        <div class="flex items-center space-x-4">
          <img class="h-20 w-20 rounded-full" src={~p"/images/profile_pic.webp"} aria-hidden="true" />
          <h1 class="text-3xl text-dark-200 font-extrabold">Basile Nouvellet</h1>
        </div>

        <p class="max-w-lg mt-4 text-dark-400">
          Product software engineer aiming at building rich, interactive web applications quickly, with less code and fewer moving parts
        </p>

        <div>
          <%!-- BUILDING --%>
          <.section_title class="mt-16">
            <:title>building</:title>
          </.section_title>

          <div class="w-fit mt-4 grid grid-cols-1 gap-x-6 gap-y-4 sm:grid-cols-2">
            <.card_link_with_image
              url="https://piga.io"
              img_url={~p"/images/piga-logo-192.webp"}
              label="Piga"
            />

            <.card_link_with_image
              url="https://beachkam.com"
              img_url={~p"/images/beachkam-logo-192.webp"}
              label="Beachkam"
            />
          </div>

          <%!-- WRITING --%>
          <.section_title class="mt-16">
            <:title>writing</:title>
            <:action>
              <.link
                navigate={~p"/writing"}
                class={[
                  "py-0.5 px-1.5 flex items-center space-x-2",
                  "text-sm text-dark-400 hover:text-dark-200 hover:bg-dark-700",
                  "rounded transition group"
                ]}
              >
                see all
                <Heroicons.arrow_right
                  mini
                  class="ml-2 h-3.5 w-3.5 text-dark-500 group-hover:text-dark-300 group-hover:translate-x-0.5 transition"
                />
              </.link>
            </:action>
          </.section_title>

          <div class="mt-6 grid grid-cols-1 gap-10 sm:grid-cols-2">
            <.blog_post_card
              :for={post <- @latests_posts}
              id={post.id}
              navigate={~p"/writing/#{post}"}
              title={post.title}
              img_url={post.picture_url}
              class="max-w-sm"
            />
          </div>

          <%!-- CONTACT --%>
          <.section_title class="mt-16">
            <:title>contact</:title>
          </.section_title>

          <div class="w-fit mt-4 flex flex-wrap gap-6 text-sm text-dark-400">
            <.link_with_icon url="https://twitter.com/basilenouvellet" label="basilenouvellet">
              <:icon>
                <svg
                  viewBox="0 0 16 16"
                  aria-hidden="true"
                  fill="currentColor"
                  class="h-4 w-4 text-dark-500 group-hover:text-dark-100 transition"
                >
                  <path d="M5.403 14c5.283 0 8.172-4.617 8.172-8.62 0-.131 0-.262-.008-.391A6.033 6.033 0 0 0 15 3.419a5.503 5.503 0 0 1-1.65.477 3.018 3.018 0 0 0 1.263-1.676 5.579 5.579 0 0 1-1.824.736 2.832 2.832 0 0 0-1.63-.916 2.746 2.746 0 0 0-1.821.319A2.973 2.973 0 0 0 8.076 3.78a3.185 3.185 0 0 0-.182 1.938 7.826 7.826 0 0 1-3.279-.918 8.253 8.253 0 0 1-2.64-2.247 3.176 3.176 0 0 0-.315 2.208 3.037 3.037 0 0 0 1.203 1.836A2.739 2.739 0 0 1 1.56 6.22v.038c0 .7.23 1.377.65 1.919.42.54 1.004.912 1.654 1.05-.423.122-.866.14-1.297.052.184.602.541 1.129 1.022 1.506a2.78 2.78 0 0 0 1.662.598 5.656 5.656 0 0 1-2.007 1.074A5.475 5.475 0 0 1 1 12.64a7.827 7.827 0 0 0 4.403 1.358" />
                </svg>
              </:icon>
            </.link_with_icon>

            <.link_with_icon url="https://github.com/basilenouvellet" label="basilenouvellet">
              <:icon>
                <svg
                  viewBox="0 0 24 24"
                  aria-hidden="true"
                  fill="currentColor"
                  class="h-4 w-4 text-dark-500 group-hover:text-dark-100 transition"
                >
                  <path d="M12 .297c-6.63 0-12 5.373-12 12 0 5.303 3.438 9.8 8.205 11.385.6.113.82-.258.82-.577 0-.285-.01-1.04-.015-2.04-3.338.724-4.042-1.61-4.042-1.61C4.422 18.07 3.633 17.7 3.633 17.7c-1.087-.744.084-.729.084-.729 1.205.084 1.838 1.236 1.838 1.236 1.07 1.835 2.809 1.305 3.495.998.108-.776.417-1.305.76-1.605-2.665-.3-5.466-1.332-5.466-5.93 0-1.31.465-2.38 1.235-3.22-.135-.303-.54-1.523.105-3.176 0 0 1.005-.322 3.3 1.23.96-.267 1.98-.399 3-.405 1.02.006 2.04.138 3 .405 2.28-1.552 3.285-1.23 3.285-1.23.645 1.653.24 2.873.12 3.176.765.84 1.23 1.91 1.23 3.22 0 4.61-2.805 5.625-5.475 5.92.42.36.81 1.096.81 2.22 0 1.606-.015 2.896-.015 3.286 0 .315.21.69.825.57C20.565 22.092 24 17.592 24 12.297c0-6.627-5.373-12-12-12" />
                </svg>
              </:icon>
            </.link_with_icon>

            <.link_with_icon url="mailto:b.nouvellet+website@gmail.com" label="Send me an email">
              <:icon>
                <Heroicons.envelope
                  solid
                  aria-hidden="true"
                  fill="currentColor"
                  class="h-4 w-4 text-dark-500 group-hover:text-dark-100 transition"
                />
              </:icon>
            </.link_with_icon>
          </div>
        </div>
      </div>
    </div>
    """
  end

  ### Components

  attr :class, :string, default: nil
  slot :title, required: true
  slot :action, required: false

  def section_title(assigns) do
    ~H"""
    <div class={["flex items-baseline space-x-4", @class]}>
      <h2 class="text-base text-dark-200 font-bold"><%= render_slot(@title) %></h2>
      <%= render_slot(@action) %>
    </div>
    """
  end

  ### Server

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket, layout: false}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    {:noreply,
     socket
     |> assign(latests_posts: Enum.take(Writing.all_posts(), 2))
     |> assign_page_meta()}
  end

  ### Helpers

  def assign_page_meta(socket) do
    assign(socket, page_title: "Basile Nouvellet")
  end
end
