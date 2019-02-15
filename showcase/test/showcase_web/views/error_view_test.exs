defmodule ShowcaseWeb.ErrorViewTest do
  use ShowcaseWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.html", %{conn: conn} do
    conn = get(conn, "/error")
    assert render_to_string(ShowcaseWeb.ErrorView, "404.html", [conn: conn]) =~ "does not exist"
  end

  test "renders 500.html" do
    assert render_to_string(ShowcaseWeb.ErrorView, "500.html", []) == "Internal Server Error"
  end
end
