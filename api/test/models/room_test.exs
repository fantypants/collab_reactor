defmodule CollabReactor.RoomTest do
  use CollabReactor.ModelCase

  alias CollabReactor.Room

  @valid_attrs %{name: "some name", topic: "some topic"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Room.changeset(%Room{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Room.changeset(%Room{}, @invalid_attrs)
    refute changeset.valid?
  end
end
