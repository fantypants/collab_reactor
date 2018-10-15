defmodule CollabReactor.Services.UserMessage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_messages" do
    field :body, :string
    field :group, :integer
    belongs_to :user, Services.CollabReactor.User, foreign_key: :user_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:body, :group, :user_id])
    |> validate_required([:body, :group, :user_id])
  end
end
