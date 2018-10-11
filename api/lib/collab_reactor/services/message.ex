defmodule CollabReactor.Services.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :text, :string
    belongs_to :room, CollabReactor.Services.Room, foreign_key: :room_id
    belongs_to :user, Services.CollabReactor.User, foreign_key: :user_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:text, :user_id, :room_id])
    |> validate_required([:text, :user_id, :room_id])
  end
end
