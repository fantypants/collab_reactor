defmodule CollabReactorWeb.InterestController do
  use CollabReactorWeb, :controller
  alias CollabReactor.Repo
  alias CollabReactor.Services.Interest
  import Ecto.Query

  plug Guardian.Plug.EnsureAuthenticated, handler: CollabReactorWeb.SessionController

  def index(conn, _params) do
    interests = Repo.all(Interest)
    render(conn, "index.json", interests: interests)
  end

  def create(conn, params) do
    current_user = Guardian.Plug.current_resource(conn)
    changeset = Interest.changeset(%Interest{}, params)
    case Repo.insert(changeset) do

      {:ok, interest} ->
        IO.inspect interest
        conn
        |> put_status(:created)
      {:error, changeset} ->
        IO.inspect changeset
        conn
        |> put_status(:unprocessable_entity)
        |> render(CollabReactorWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
