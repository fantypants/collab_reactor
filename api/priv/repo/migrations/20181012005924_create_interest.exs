defmodule CollabReactor.Repo.Migrations.CreateInterest do
  use Ecto.Migration

  def change do
    create table(:interests) do
      add :title, :string
      add :group_id, references(:groups, on_delete: :nothing)


      timestamps()
    end
    create index(:interests, [:group_id])
  end
end
