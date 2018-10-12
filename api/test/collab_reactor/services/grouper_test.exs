defmodule CollabReactor.Services.GrouperTest do
use CollabReactor.DataCase

alias CollabReactor.Services.Grouper

test "Grouper Module is Available" do
  changeset = Services.CollabReactor.User.registration_changeset(%Services.CollabReactor.User{}, %{email: "admin3@gmail.com", username: "matthew3", password: "password", profession: "Software Engineer"})
  changeset1 = Services.CollabReactor.User.registration_changeset(%Services.CollabReactor.User{}, %{email: "admin4@gmail.com", username: "matthew4", password: "password", profession: "Designer"})
  changeset2 = Services.CollabReactor.User.registration_changeset(%Services.CollabReactor.User{}, %{email: "admin5@gmail.com", username: "matthew5", password: "password", profession: "Growth Hacker"})
  CollabReactor.Repo.insert(changeset)
  CollabReactor.Repo.insert(changeset1)
  CollabReactor.Repo.insert(changeset2)
  assert Grouper.get_free_users(%{"interest" => "Aerospace"}) == [
    %{profession: "Software Engineer", username: "matthew3"},
    %{profession: "Designer", username: "matthew4"},
    %{profession: "Growth Hacker", username: "matthew5"}]
end

test "Create a Group Works" do
  changeset = Services.CollabReactor.User.registration_changeset(%Services.CollabReactor.User{}, %{email: "admin3@gmail.com", username: "matthew3", password: "password", profession: "Software Engineer"})
  changeset1 = Services.CollabReactor.User.registration_changeset(%Services.CollabReactor.User{}, %{email: "admin4@gmail.com", username: "matthew4", password: "password", profession: "Designer"})
  changeset2 = Services.CollabReactor.User.registration_changeset(%Services.CollabReactor.User{}, %{email: "admin5@gmail.com", username: "matthew5", password: "password", profession: "Growth Hacker"})
  CollabReactor.Repo.insert(changeset)
  CollabReactor.Repo.insert(changeset1)
  CollabReactor.Repo.insert(changeset2)
  assert Grouper.create_group(%{"interest" => "Aerospace"}) == %{users: [
    %{username: "matthew3", profession: "Software Engineer"},
    %{username: "matthew4", profession: "Designer"},
    %{username: "matthew5", profession: "Growth Hacker"}], interest: "Aerospace"}
end

end
