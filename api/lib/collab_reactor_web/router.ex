defmodule CollabReactorWeb.Router do
  use CollabReactorWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CollabReactorWeb do
    pipe_through :api
  end
end
