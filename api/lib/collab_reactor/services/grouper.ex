defmodule CollabReactor.Services.Grouper do
  alias CollabReactor.Services.Group
  alias CollabReactor.Services.Interest
  alias Services.CollabReactor.User
  alias CollabReactorWeb.UserController
  alias CollabReactor.Repo
  import Ecto.Query

  @valid_pairsA ["Software Engineer",
                "Designer",
                "Growth Hacker",
                "Digital Marketer",
                "Project Manager"]
  @valid_pairsB ["Software Engineer",
                 "Designer"]
  @valid_pairsC ["Software Engineer",
                "Designer",
                "Growth Hacker"]


  def get_free_users(%{"interest" => interest}) do
    query = from u in User, select: %{username: u.username, profession: u.profession}, limit: 10
    Repo.all(query)
  end

  def create_group(%{"interest" => interest}) do
    users_free = get_free_users(%{"interest" => interest})
    %{interest: interest, users: users_free}
  end

  def collect_group(id) do
    interest_ids = get_user_interests(id)
    user_interest_map = interest_ids |> Enum.map(fn id -> get_users_with_interests(id) end) |> IO.inspect
    sized_common_interest = user_interest_map |> get_most_common_interest |> IO.inspect
    by_profession = sized_common_interest |> Enum.map(fn list -> get_by_profession(list) end) |> IO.inspect
  end

  def get_user_interests(id) do
    user = Repo.get!(User, id) |> Repo.preload(:interests) |> IO.inspect
    interests = Repo.all(Ecto.assoc(user, :interests)) |> Enum.map(&(&1.id))
  end

  def get_users_with_interests(interest_id) do
    query = from u in User, left_join: i in assoc(u, :interests), where: i.id == ^interest_id, select: %{user_id: u.id, username: u.username, interest: i.title, profession: u.profession}
    users = Repo.all(query)
  end

  def get_most_common_interest(user_interest_map) do
    user_interest_map |> Enum.map(fn(a) -> {Enum.count(a), a} end)
  end


  def of([]) do
    [[]]
  end

  def of(list) do
    for h <- list, t <- of(list -- [h]), do: [h | t]
  end

  defp get_uniq_professions(map) do
    Enum.group_by(map, fn user -> user.profession end)
  end

  defp find_professionals(map) do
    keys = Map.keys(map)
    keys |> Enum.map(fn(key) -> get_professional(map["#{key}"]) end)
  end
  defp get_professional(list) do
    IO.puts "Finding the Professional"
    Enum.take_random(list, 1)
  end


  defp validate_group(list) do
    valid_groups = of(@valid_pairsA) ++ of(@valid_pairsB) ++ of(@valid_pairsC)
    group = Enum.reject(valid_groups, fn grouping -> grouping !== list end)
    case group do
      [] ->
        :error
      _->
        :ok
    end
  end

  def get_by_profession(list) do
    {size, map} = list
    valid_group = map |> Enum.reduce([], fn (profession, acc) -> List.insert_at(acc, 0, profession.profession) end)
    #validate = of(valid_group) |> Enum.map(fn grouping -> validate_group(grouping) end)
    map |> get_uniq_professions
        |> find_professionals
        |> IO.inspect
    {size, map}
  end
end
