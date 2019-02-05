defmodule ShowcaseWeb.PageController do
  use ShowcaseWeb, :controller

  plug :assign_welcome_hi, "Hi!" when action in [:index, :index_no_header, :jsonIndex]

  action_fallback ShowcaseWeb.FallbackController

  def index_no_header(conn, %{"message" => message} = params) do
    conn
    |> put_layout("app_no_header.html")
    |> put_flash(:info, "Welcome to Phoenix, from flash info!")
    |> put_flash(:error, "Let's pretend we have an error.")
    |> render("index.html", message: message)
  end

  def index(conn, %{"message" => message} = params) do
    conn
    |> put_flash(:info, "Welcome to Phoenix, from flash info!")
    |> put_flash(:error, "Let's pretend we have an error.")
    |> render(:index, message: message)
  end

  def error(conn, _params) do
    with {:ok} <- {:error, :not_found} do
      conn
      |> render("index.html")
    end
  end

  def redirect_test(conn, _params) do
    redirect(conn, to: Routes.page_path(conn, :index, "redirect"))
  end

  def json_index(conn, %{"message" => message} = params) do
    json(conn, %{message: message})
  end

  defp assign_welcome_hi(conn, msg) do
    assign(conn, :hi, msg)
  end

  def none(conn, _params) do
  conn
  |> send_resp(201, "")
end
end
