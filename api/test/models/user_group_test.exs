defmodule CollabReactor.UserGroupTest do
  use CollabReactor.ModelCase

  alias CollabReactor.UserGroup

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserGroup.changeset(%UserGroup{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserGroup.changeset(%UserGroup{}, @invalid_attrs)
    refute changeset.valid?
  end
end
