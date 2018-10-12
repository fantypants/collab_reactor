defmodule CollabReactorWeb.MessageController do
  use CollabReactorWeb, :controller
  alias CollabReactor.Repo
  import Ecto.Query

  plug Guardian.Plug.EnsureAuthenticated, handler: CollabReactorWeb.SessionController

  def index(conn, params) do
    last_seen_id = params["last_seen_id"] || 0
    room = Repo.get!(Collabreactor.Services.Room, params["room_id"])

    page =
      CollabReactor.Services.Message
      |> where([m], m.room_id == ^room.id)
      |> where([m], m.id < ^last_seen_id)
      |> order_by([desc: :inserted_at, desc: :id])
      |> preload(:user)
      |> CollabReactor.Repo.paginate()

    render(conn, "index.json", %{messages: page.entries, pagination: CollabReactorweb.PaginationHelpers.pagination(page)})
  end
end
