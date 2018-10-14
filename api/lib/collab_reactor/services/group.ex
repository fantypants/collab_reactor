defmodule CollabReactor.Services.Group do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :title, :string
    has_many :interests, CollabReactor.Services.Interest
    many_to_many :users, Services.CollabReactor.User, join_through: "user_groups"

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> cast_assoc(:interests)
    |> validate_required([:title])
  end
end
