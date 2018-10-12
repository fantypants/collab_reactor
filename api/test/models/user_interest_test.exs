defmodule CollabReactor.UserInterestTest do
  use CollabReactor.ModelCase

  alias CollabReactor.UserInterest

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserInterest.changeset(%UserInterest{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserInterest.changeset(%UserInterest{}, @invalid_attrs)
    refute changeset.valid?
  end
end
