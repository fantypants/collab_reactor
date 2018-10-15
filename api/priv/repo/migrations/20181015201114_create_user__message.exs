defmodule CollabReactor.Repo.Migrations.CreateUser_Message do
  use Ecto.Migration

  def change do
    create table(:user_messages) do
      add :body, :string
      add :group, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:user_messages, [:user_id])
  end
end
