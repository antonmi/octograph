defmodule Octograph.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    # plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Octograph do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/user_nodes", UserNodesController, only: [:index]
    resource "user_spider", UserSpiderController, only: [:show] do
      post "/start", UserSpiderController, :start, as: :start
      post "/stop", UserSpiderController, :stop, as: :stop
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", Octograph do
  #   pipe_through :api
  # end
end
