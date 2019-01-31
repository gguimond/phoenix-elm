defmodule ShowcaseWeb.Router do
  use ShowcaseWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end


  scope "/", ShowcaseWeb do
    pipe_through :browser

    get "/home/:message", PageController, :index
  end

  scope "/jobs", ShowcaseWeb do

    forward "/", BackgroundJob.Plug, name: "Bckg job"
  end

  # Other scopes may use custom stacks.
  # scope "/api", ShowcaseWeb do
  #   pipe_through :api
  # end
end
