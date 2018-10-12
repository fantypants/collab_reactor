defmodule CollabReactor.Repo.Migrations.CreateGroup do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :title, :string


      timestamps()
    end
  end
end
