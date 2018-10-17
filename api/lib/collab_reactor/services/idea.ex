defmodule CollabReactor.Services.Idea do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ideas" do
    field :name, :string
    field :difficulty, :integer
    field :time, :integer
    field :appeal, :integer
    belongs_to :group, CollabReactor.Services.Group, foreign_key: :group_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :difficulty, :time, :appeal, :group_id])
    |> validate_required([:name, :group_id])
  end
end
