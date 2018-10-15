defmodule CollabReactorWeb.GroupController do
  use CollabReactorWeb, :controller
  alias CollabReactor.Repo
  alias CollabReactor.Services.Group
  alias Services.CollabReactor.User
  alias CollabReactor.Services.UserGroup
  import Ecto.Query

  plug Guardian.Plug.EnsureAuthenticated, handler: CollabReactorWeb.SessionController


  def index(conn, _params) do
    groups = Repo.all(Group) |> IO.inspect
    render(conn, "index.json", groups: groups)
  end

  def collect_and_create_group(conn, params) do
    current_user = Guardian.Plug.current_resource(conn)
    user = Repo.get!(User, current_user.id)
    group = CollabReactor.Services.Grouper.collect_group(current_user.id)
    group_map = group
      |> Enum.map(fn user -> %{user_id: user.user_id, profession: user.profession} end)
    interest = group
        |> Enum.reduce(0, fn user, acc -> user.interest end)
        |> IO.inspect
    user_map = %{user_id: user.id, profession: user.profession}
    if Enum.member?(group_map, user_map) == true do
      group_map
    else
      check_size_and_add_user(user_map, group_map)
    end
    with {:ok, group} <- create_private(interest) do
      group_id = group.id
      result = group_map |> Enum.map(fn user -> %{user_id: user.id, profession: user.profession, group_id: group_id} end)
    end
    IO.inspect result
    #Find All Users Needed
    #Add Current User
    #Create Group
    #Put group ID in map
    #Insert all data into the user_pm_table
    groups = Repo.all(Group)
    render(conn, "index.json", groups: groups)
  end

  defp check_size_and_add_user(user, group) do
    size = Enum.count(group)
    case size do
      5 ->
        result_group = Enum.drop(group, -1) ++ user
      _->
        result_group = group ++ user
    end
  end

  defp create_private(interest) do
    changeset = Group.changeset(%Group{}, %{"title" => interest})

    case Repo.insert(changeset) do
      {:ok, group} ->
      {:ok, group}
      {:error, changeset} ->
        IO.inspect changeset
      {:error, changeset}
    end
  end

  def create(conn, params) do
    current_user = Guardian.Plug.current_resource(conn)
    changeset = Group.changeset(%Group{}, %{"title" => "New Random Title"})

    case Repo.insert(changeset) do
      {:ok, group} ->
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

  def update_user_group(conn, params) do
    current_user = Guardian.Plug.current_resource(conn)
    group_id = params["id"]
    changeset = UserGroup.changeset(
      %UserGroup{},
      %{user_id: current_user.id, group_id: group_id}
    )
    case Repo.insert(changeset) do
      {:ok, group} ->
        conn
        |> put_status(:created)
        |> render("user_group_show.json", group: group)
      {:error, changeset} ->
        IO.inspect changeset
        conn
        |> put_status(:unprocessable_entity)
        |> render(CollabReactorWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end


end
