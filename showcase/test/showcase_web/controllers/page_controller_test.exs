defmodule ShowcaseWeb.PageControllerTest do
  use ShowcaseWeb.ConnCase
  setup [:create_user]

  test "GET /home/:message", %{conn: conn} do
    conn = get(conn, "/home/message")
    assert html_response(conn, 200) =~ "Welcome to Phoenix"
  end

  test "GET /home/:message/json", %{conn: conn, user: user} do
    IO.inspect user
    response =
    conn
    |> get(Routes.page_path(conn, :json_index, "message"))
    |> json_response(200)

    expected = %{"message" => "message"}

    assert response == expected
  end

  defp create_user(_) do
    user = Showcase.User.changeset(%Showcase.User{}, %{name: "guimog", email: "guimog@guimog.com"})
    user = Showcase.Repo.insert!(user)
    {:ok, user: user}
    end
end
