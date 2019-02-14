defmodule ShowcaseWeb.PageController do
  use ShowcaseWeb, :controller
  import Ecto.Query, only: [from: 2]

  plug :assign_welcome_hi, "Hi!" when action in [:index, :index_no_header, :jsonIndex]

  action_fallback ShowcaseWeb.FallbackController

  def index_no_header(conn, %{"message" => message}) do
    conn
    |> put_layout("app_no_header.html")
    |> put_flash(:info, "Welcome to Phoenix, from flash info!")
    |> put_flash(:error, "Let's pretend we have an error.")
    |> render("index.html", message: message)
  end

  def index(conn, %{"message" => message}) do
    #valid
    user = Showcase.User.changeset(%Showcase.User{}, %{name: "guimog", email: "guimog@guimog.com"})
    if user.valid? do
      info = Showcase.Repo.insert!(user)
      Showcase.Repo.delete!(info)
    end
    #not valid
    user2 = Showcase.User.changeset(%Showcase.User{}, %{name: "guimog", email: "wrong"})
    if user2.valid? do
      Showcase.Repo.insert!(user2)
    end
    regex = Mongo.Ecto.Helpers.regex("guimog@guimog.com", "i")
    query = from u in Showcase.User,
      where: fragment(email: ^regex),
      select: u.name
    result = Showcase.Repo.all(query)
    conn
    |> put_flash(:info, "Welcome to Phoenix, from flash info!")
    |> put_flash(:error, "Let's pretend we have an error.")
    |> render(:index, message: message <> " " <> List.first(result))
  end

  def error(conn, _params) do
    with {:ok} <- {:error, :not_found} do
      conn
      |> render("index.html")
    end
  end

  def no_route(conn, _params) do
    raise ShowcaseWeb.Router.NoRouteError, [{:conn, conn}, {:router, ShowcaseWeb.Router}]
  end

  def redirect_test(conn, _params) do
    redirect(conn, to: Routes.page_path(conn, :index, "redirect"))
  end

  def json_index(conn, %{"message" => message}) do
    json(conn, %{message: message})
  end

  def json_template(conn, _params) do
    pages = [%{title: "foo"}, %{title: "bar"}]
    render(conn, "index.json", pages: pages)
  end

  defp assign_welcome_hi(conn, msg) do
    assign(conn, :hi, msg)
  end

  def none(conn, _params) do
  conn
  |> send_resp(201, "")
end
end
