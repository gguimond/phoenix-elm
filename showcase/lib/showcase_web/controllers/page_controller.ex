defmodule ShowcaseWeb.PageController do
  use ShowcaseWeb, :controller

  def index(conn, %{"message" => message} = params) do
    render(conn, "index.html", message: message)
  end
end
