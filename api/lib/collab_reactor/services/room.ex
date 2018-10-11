defmodule CollabReactor.Services.Room do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rooms" do
    field :name, :string
    field :topic, :string
    many_to_many :users, Services.CollabReactor.User, join_through: "user_rooms"
    has_many :messages, CollabReactor.Services.Message
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
      |> cast(params, [:name, :topic])
      |> cast_assoc(:messages)
      |> validate_required([:name])
      |> unique_constraint(:name)
  end
end
