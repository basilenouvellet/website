defmodule Website.Writing.Post do
  @derive {Phoenix.Param, key: :id}
  @enforce_keys [
    :id,
    :title,
    :description,
    :date,
    :picture_url,
    :body
  ]
  defstruct [
    :id,
    :title,
    :description,
    :date,
    :picture_url,
    :body
  ]

  def build(filename, attrs, body) do
    [year, month_day_id] = filename |> Path.rootname() |> Path.split() |> Enum.take(-2)
    [month, day, id] = String.split(month_day_id, "-", parts: 3)

    date = Date.from_iso8601!("#{year}-#{month}-#{day}")

    struct!(__MODULE__, [id: id, date: date, body: body] ++ Map.to_list(attrs))
  end
end
