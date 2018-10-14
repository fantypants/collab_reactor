defmodule CollabReactorWeb.Router do
  use CollabReactorWeb, :router


  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/api", CollabReactorWeb do
    pipe_through :api
    get "/test", UserController, :test
    get "/users/:id/rooms", UserController, :rooms
    get "/users/:id/interests", UserController, :interests
    resources "/rooms", RoomController, only: [:index, :create] do
      resources "/messages", MessageController, only: [:index]
    end
    post "/interests", InterestController, :create
    post "/interests/:id/join", InterestController, :update_user_interest
    get "/interests", InterestController, :index
    get "/groups", GroupController, :index
    post "/groups", GroupController, :create
    post "/rooms/:id/join", RoomController, :join
    post "/sessions", SessionController, :create
    delete "/sessions", SessionController, :delete
    post "/sessions/refresh", SessionController, :refresh
    resources "/users", UserController, only: [:create]
  end
end
