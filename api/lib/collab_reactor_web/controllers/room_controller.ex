defmodule CollabReactorWeb.RoomController do
  use CollabReactorWeb, :controller

  alias CollabReactor.Repo
  alias CollabReactor.Services.Room
  alias CollabReactor.Services.UserRoom
  alias CollabReactor.Services.GroupRoom
  import Ecto.Query

  #plug Guardian.Plug.EnsureAuthenticated, handler: CollabReactorWeb.SessionController

  def index(conn, _params) do
    rooms = Repo.all(Room)
    render(conn, "index.json", rooms: rooms)
  end

  def group_rooms(conn, params) do
    query = from g in GroupRoom, where: g.group_id == ^params["id"]
    group_rooms = Repo.all(query) |> Repo.preload(:room)
      |> Enum.map(fn group_room -> Repo.get!(Room, group_room.room_id) end)
      |> IO.inspect
    rooms = group_rooms
    render(conn, "index.json", rooms: rooms)
  end

  def create(conn, params) do
    current_user = Guardian.Plug.current_resource(conn)
    changeset = Room.changeset(%Room{}, params)

    case Repo.insert(changeset) do
      {:ok, room} ->
        assoc_changeset = UserRoom.changeset(
          %UserRoom{},
          %{user_id: current_user.id, room_id: room.id}
        )
        Repo.insert(assoc_changeset)

        conn
        |> put_status(:created)
        |> render("show.json", room: room)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(CollabReactorWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def create_group_room(conn, group_id) do
    changeset = Room.changeset(%Room{}, %{"name" => "General"})

    case Repo.insert(changeset) do
      {:ok, room} ->
        IO.inspect room
        assoc_changeset = GroupRoom.changeset(
          %GroupRoom{},
          %{group_id: group_id, room_id: room.id}
        )
        Repo.insert(assoc_changeset)

      {:error, changeset} ->
        IO.inspect changeset
    end

    rooms = Repo.all(Room)
    render(conn, "index.json", rooms: rooms)
  end

  def join(conn, %{"id" => room_id}) do
    current_user = Guardian.Plug.current_resource(conn)
    room = Repo.get(Room, room_id)

    changeset = UserRoom.changeset(
      %UserRoom{},
      %{room_id: room.id, user_id: current_user.id}
    )

    case Repo.insert(changeset) do
      {:ok, _user_room} ->
        conn
        |> put_status(:created)
        |> render("show.json", %{room: room})
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(CollabReactorWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

end
