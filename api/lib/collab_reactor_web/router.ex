defmodule CollabReactorWeb.Router do
  use CollabReactorWeb, :router


  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/api", CollabReactorWeb do
    pipe_through :api
    get "/users/:id/rooms", UserController, :rooms
    resources "/rooms", RoomController, only: [:index, :create] do
      resources "/messages", MessageController, only: [:index]
    end
    post "/groups", GroupController, :create
    post "/rooms/:id/join", RoomController, :join
    post "/sessions", SessionController, :create
    delete "/sessions", SessionController, :delete
    post "/sessions/refresh", SessionController, :refresh
    resources "/users", UserController, only: [:create]
  end
end
