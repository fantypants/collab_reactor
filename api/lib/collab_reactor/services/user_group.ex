defmodule CollabReactor.Services.UserGroup do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_groups" do
    belongs_to :user, Services.CollabReactor.User, foreign_key: :user_id
    belongs_to :group, CollabReactor.Services.Group, foreign_key: :group_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :group_id])
    |> validate_required([:user_id, :group_id])
    |> unique_constraint(:user_id_group_id)
  end
end
