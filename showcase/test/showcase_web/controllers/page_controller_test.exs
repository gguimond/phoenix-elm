defmodule ShowcaseWeb.PageControllerTest do
  use ShowcaseWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/home/message")
    assert html_response(conn, 200) =~ "Welcome to Phoenix"
  end
end
