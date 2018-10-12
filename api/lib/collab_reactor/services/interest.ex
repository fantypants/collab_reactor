defmodule CollabReactor.Services.Interest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "interests" do
    field :title, :string
    belongs_to :groups, CollabReactor.Services.Group, foreign_key: :group_id
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :group_id])
    |> validate_required([:title])
  end
end
