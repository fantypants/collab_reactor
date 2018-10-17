defmodule CollabReactorWeb.IdeaController do
  use CollabReactorWeb, :controller
  alias CollabReactor.Repo
  alias CollabReactor.Services.Group
  alias Services.CollabReactor.User
  alias CollabReactor.Services.Idea
  alias CollabReactor.Services.UserGroup
  alias CollabReactorWeb.RoomController
  alias CollabReactorWeb.UserMessageController
  import Ecto.Query

  #plug Guardian.Plug.EnsureAuthenticated, handler: CollabReactorWeb.SessionController

  def create(conn, params) do
    group_id = params["id"]
    data = params["data"]
    name = data["name"]
    idea_params = %{"name" => name, "group_id" => group_id}
    changeset = Idea.changeset(%Idea{}, idea_params)
    case Repo.insert(changeset) do
      {:ok, idea} ->
        conn
        |> put_status(:created)
        |> render("show.json", idea: idea)
      {:error, changeset} ->
        IO.inspect changeset
        conn
        |> put_status(:unprocessable_entity)
        |> render(CollabReactorWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end




end
