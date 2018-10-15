defmodule CollabReactor.User_MessageTest do
  use CollabReactor.ModelCase

  alias CollabReactor.User_Message

  @valid_attrs %{body: "some body", group: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User_Message.changeset(%User_Message{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User_Message.changeset(%User_Message{}, @invalid_attrs)
    refute changeset.valid?
  end
end
