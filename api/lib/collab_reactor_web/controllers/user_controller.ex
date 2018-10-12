defmodule CollabReactorWeb.UserController do
  use CollabReactorWeb, :controller

  #Salias Services.CollabReactor
  alias CollabReactor.Repo
  alias Services.CollabReactor.User

  action_fallback CollabReactorWeb.FallbackController
  plug Guardian.Plug.EnsureAuthenticated, [handler: CollabReactorWeb.SessionController] when action in [:rooms]


  def index(conn, _params) do
    users = CollabReactor.list_users()
    render(conn, "index.json", users: users)
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

  def rooms(conn, _params) do
    current_user = Guardian.Plug.current_resource(conn)
    rooms = Repo.all(Ecto.build_assoc(current_user, :rooms))
    render(conn, CollabReactorWeb.RoomView, "index.json", %{rooms: rooms})
  end
end
