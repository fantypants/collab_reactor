defmodule CollabReactorWeb.InterestController do
  use CollabReactorWeb, :controller
  alias CollabReactor.Repo
  alias CollabReactor.Services.Interest
  alias CollabReactor.Services.UserInterest
  import Ecto.Query

  plug Guardian.Plug.EnsureAuthenticated, handler: CollabReactorWeb.SessionController

  def index(conn, _params) do
    interests = Repo.all(Interest)
    render(conn, "index.json", interests: interests)
  end

  def get_interest(interest) do
    query = from i in Interest, where: i.title == ^interest
    Repo.get!(query)
  end

  def update_user_interest(conn, params) do
    current_user = Guardian.Plug.current_resource(conn)
    interest_id = params["id"]
    changeset = UserInterest.changeset(
      %UserInterest{},
      %{user_id: current_user.id, interest_id: interest_id}
    )
    case Repo.insert(changeset) do
      {:ok, interest} ->
        IO.inspect interest
        conn
        |> put_status(:created)
        |> render("user_interest_show.json", interest: interest)
      {:error, changeset} ->
        IO.inspect changeset
        conn
        |> put_status(:unprocessable_entity)
        |> render(CollabReactorWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def create(conn, params) do
    current_user = Guardian.Plug.current_resource(conn)
    changeset = Interest.changeset(%Interest{}, params)
    case Repo.insert(changeset) do

      {:ok, interest} ->
        IO.inspect interest
        conn
        |> put_status(:created)
        |> render("show.json", interest: interest)
      {:error, changeset} ->
        IO.inspect changeset
        conn
        |> put_status(:unprocessable_entity)
        |> render(CollabReactorWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
