defmodule :"Elixir.CollabReactor.Repo.Migrations.Creating group rooms+" do
  use Ecto.Migration

  def change do
    create table(:group_rooms) do
      add :group_id, references(:groups, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)
      add :room_id, references(:rooms, on_delete: :nothing)

      timestamps()
    end

    create index(:group_rooms, [:group_id])
    create index(:group_rooms, [:user_id])
    create index(:group_rooms, [:room_id])
    create index(:group_rooms, [:group_id, :room_id, :user_id], unique: true)
  end
end
