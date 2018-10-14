defmodule :"Elixir.CollabReactor.Repo.Migrations.Adding userId to groups" do
  use Ecto.Migration

  def change do
    alter table(:groups) do
      add :user_id, references(:users, on_delete: :nothing)
    end
    create index(:groups, [:user_id])
  end
end
