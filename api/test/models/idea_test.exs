defmodule CollabReactor.IdeaTest do
  use CollabReactor.ModelCase

  alias CollabReactor.Idea

  @valid_attrs %{appeal: 42, difficulty: 42, name: "some name", time: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Idea.changeset(%Idea{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Idea.changeset(%Idea{}, @invalid_attrs)
    refute changeset.valid?
  end
end
