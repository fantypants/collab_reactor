defmodule CollabReactor.Services.Grouper do
  alias CollabReactor.Services.Group
  alias CollabReactor.Services.Interest
  alias Services.CollabReactor.User
  alias CollabReactor.Repo
  import Ecto.Query

  @valid_pairs ["Software Engineer",
                "Designer",
                "Growth Hacker",
                "Digital Marketer"]

  def get_free_users(%{"interest" => interest}) do
    query = from u in User, select: %{username: u.username, profession: u.profession}, limit: 10
    Repo.all(query)
  end

  def create_group(%{"interest" => interest}) do
    users_free = get_free_users(%{"interest" => interest})
    %{interest: interest, users: users_free}
  end
end
