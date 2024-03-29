defmodule CollabReactor.MessageTest do
  use CollabReactor.ModelCase

  alias CollabReactor.Message

  @valid_attrs %{text: "some text"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Message.changeset(%Message{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Message.changeset(%Message{}, @invalid_attrs)
    refute changeset.valid?
  end
end
