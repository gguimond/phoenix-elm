defmodule ShowcaseWeb.FallbackController do
  use Phoenix.Controller
  alias ShowcaseWeb.ErrorView

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render(:"404")
  end

end