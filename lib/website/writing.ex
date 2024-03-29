defmodule Website.Writing do
  alias Website.Writing.Post

  use NimblePublisher,
    build: Post,
    from: Application.app_dir(:website, "priv/posts/**/*.md"),
    as: :posts,
    highlighters: [:makeup_elixir]

  # The @posts variable is first defined by NimblePublisher.
  # Let's further modify it by sorting all posts by descending date.
  @posts Enum.sort_by(@posts, & &1.date, {:desc, Date})

  # Let's also get all tags
  # @tags @posts |> Enum.flat_map(& &1.tags) |> Enum.uniq() |> Enum.sort()

  # And finally export them
  def all_posts, do: @posts
  # def all_tags, do: @tags

  def get_post_by_id!(id) do
    Enum.find(all_posts(), &(&1.id == id)) ||
      raise WebsiteWeb.Error.NotFound, "post with id='#{String.slice(id, 0, 50)}' not found"
  end

  # def get_posts_by_tag!(tag) do
  #   case Enum.filter(all_posts(), &(tag in &1.tags)) do
  #     [] -> raise WebsiteWeb.Error.NotFound, "posts with tag='#{String.slice(tag, 0, 50)}' not found"
  #     posts -> posts
  #   end
  # end
end
