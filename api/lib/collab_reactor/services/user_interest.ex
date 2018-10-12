defmodule CollabReactor.Services.UserInterest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_interests" do
    belongs_to :user, CollabReactor.User, foreign_key: :user_id
    belongs_to :interest, CollabReactor.Interest, foreign_key: :interest_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :interest_id])
    |> validate_required([:user_id, :interest_id])
    |> unique_constraint(:user_id_interest_id)
  end
end
