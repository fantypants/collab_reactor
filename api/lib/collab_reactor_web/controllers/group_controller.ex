defmodule CollabReactorWeb.GroupController do
  use CollabReactorWeb, :controller
  alias CollabReactor.Repo
  alias CollabReactor.Services.Group
  import Ecto.Query

  plug Guardian.Plug.EnsureAuthenticated, handler: CollabReactorWeb.SessionController


  def index(conn, _params) do
    groups = Repo.all(Group) |> IO.inspect
    render(conn, "index.json", groups: groups)
  end

  def create(conn, params) do
    current_user = Guardian.Plug.current_resource(conn)
    changeset = Group.changeset(%Group{}, %{"title" => "New Random Title"})

    case Repo.insert(changeset) do

      {:ok, group} ->
        IO.inspect group
        conn
        |> put_status(:created)
        |> render("show.json", group: group)
      {:error, changeset} ->
        IO.inspect changeset
        conn
        |> put_status(:unprocessable_entity)
        |> render(CollabReactorWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
