defmodule WebsiteWeb.HomeLiveTest do
  use WebsiteWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "GET /", %{conn: conn} do
    {:ok, _view, html} = live(conn, ~p"/")
    assert html =~ "Basile Nouvellet"
  end
end
