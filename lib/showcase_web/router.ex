defmodule ShowcaseWeb.Plugs.Locale do
  import Plug.Conn

  @locales ["en", "fr", "de"]

  def init(default), do: default

  def call(%Plug.Conn{params: %{"locale" => loc}} = conn, _default) when loc in @locales do
    assign(conn, :locale, loc)
  end
  def call(conn, default), do: assign(conn, :locale, default)
end


defmodule ShowcaseWeb.Router do
  use ShowcaseWeb, :router

  pipeline :browser do
    plug :put_user_token
    plug :accepts, ["html", "text"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug ShowcaseWeb.Plugs.Locale, "en"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end


  scope "/", ShowcaseWeb do
    pipe_through :browser

    get "/noheader/home/:message", PageController, :index_no_header
    get "/home/:message", PageController, :index
    get "/home/:message/json", PageController, :json_index
    get "/none", PageController, :none
    get "/error", PageController, :error
    get "/redirect", PageController, :redirect_test
    get "/json/template", PageController, :json_template
    get "/noroute", PageController, :no_route
  end

  scope "/jobs", ShowcaseWeb do

    forward "/", BackgroundJob.Plug, name: "Bckg job"
  end

  # Other scopes may use custom stacks.
  # scope "/api", ShowcaseWeb do
  #   pipe_through :api
  # end

  
  defp put_user_token(conn, _) do
    token = Phoenix.Token.sign(conn, "user socket", 1)
    assign(conn, :user_token, token)
  end

  defmodule NoRouteError do
    @moduledoc """
    Exception raised when no route is found.
    """
    defexception plug_status: 404, message: "no route found", conn: nil, router: nil

    def exception(opts) do
      conn   = Keyword.fetch!(opts, :conn)
      router = Keyword.fetch!(opts, :router)
      path   = "/" <> Enum.join(conn.path_info, "/")

      ex = %NoRouteError{message: "no route found for #{conn.method} #{path} (#{inspect router})",
      conn: conn, router: router}
      IO.inspect ex
      ex
    end
  end
end
