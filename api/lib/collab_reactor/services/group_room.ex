defmodule CollabReactor.Services.GroupRoom do
  use Ecto.Schema
  import Ecto.Changeset

  schema "group_rooms" do
    belongs_to :group, CollabReactor.Services.Group, foreign_key: :group_id
    belongs_to :room, CollabReactor.Services.Room, foreign_key: :room_id
    belongs_to :user, Services.CollabReactor.User, foreign_key: :user_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
      |> cast(params, [:group_id, :room_id, :user_id])
      |> validate_required([:group_id, :room_id])
      |> unique_constraint(:user_id_group_id_room_id)
  end
end
