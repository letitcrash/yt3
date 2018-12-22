defmodule Yt3UiWeb.Router do
  use Yt3UiWeb, :router

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

  scope "/", Yt3UiWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/play", PageController, :play
    get "/watch", PageController, :yt_handler
  end

  # Other scopes may use custom stacks.
  # scope "/api", Yt3UiWeb do
  #   pipe_through :api
  # end
end
