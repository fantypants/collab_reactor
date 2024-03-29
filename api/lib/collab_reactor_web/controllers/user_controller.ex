defmodule CollabReactorWeb.UserController do
  use CollabReactorWeb, :controller

  #Salias Services.CollabReactor
  alias CollabReactor.Repo
  alias Services.CollabReactor.User
  alias CollabReactor.Services.Group
  alias CollabReactor.Services.Interest
  import Ecto.Query

  action_fallback CollabReactorWeb.FallbackController
  plug Guardian.Plug.EnsureAuthenticated, [handler: CollabReactorWeb.SessionController] when action in [:rooms]


  def index(conn, _params) do
    users = CollabReactor.list_users()
    render(conn, "index.json", users: users)
  end

  def group_users(conn, params) do
    group = Repo.get!(Group, params["id"]) |> Repo.preload(:users)
    users = group.users |> IO.inspect
    render(conn, "users_group.json", users: users)
  end

  def create(conn, params) do
    changeset = User.registration_changeset(%User{}, params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        new_conn = Guardian.Plug.api_sign_in(conn, user, :access)
        jwt = Guardian.Plug.current_token(new_conn)

        new_conn
        |> put_status(:created)
        |> render(CollabReactorWeb.SessionView, "show.json", user: user, jwt: jwt)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(CollabReactorWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = CollabReactor.get_user!(id)
    render(conn, "show.json", user: user)
  end



  def update(conn, %{"id" => id, "user" => user_params}) do
    user = CollabReactor.get_user!(id)

    with {:ok, %User{} = user} <- CollabReactor.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = CollabReactor.get_user!(id)
    with {:ok, %User{}} <- CollabReactor.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def test(conn, _params) do
    users = Services.CollabReactor.list_users()
    CollabReactor.Services.Grouper.collect_group("1")
    render(conn, "index.json", users: users)
  end

  def rooms(conn, params) do
    current_user = Guardian.Plug.current_resource(conn)
    rooms = Repo.all(Ecto.assoc(current_user, :rooms))
    render(conn, CollabReactorWeb.RoomView, "index.json", %{rooms: rooms})
  end

  def interests(conn, _params) do
    current_user = Guardian.Plug.current_resource(conn)
    interests = Repo.all(Ecto.assoc(current_user, :interests))
    render(conn, CollabReactorWeb.InterestView, "index.json", %{interests: interests})
  end


end
