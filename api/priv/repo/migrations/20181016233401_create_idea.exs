defmodule CollabReactor.Repo.Migrations.CreateIdea do
  use Ecto.Migration

  def change do
    create table(:ideas) do
      add :name, :string
      add :difficulty, :integer
      add :time, :integer
      add :appeal, :integer
      add :group_id, references(:groups, on_delete: :nothing)

      timestamps()
    end

    create index(:ideas, [:group_id])
  end
end
