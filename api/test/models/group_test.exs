defmodule CollabReactor.GroupTest do
  use CollabReactor.DataCase

  alias CollabReactor.Services.Group

  @valid_attrs %{title: "some title"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Group.changeset(%Group{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Group.changeset(%Group{}, @invalid_attrs)
    refute changeset.valid?
  end
end
