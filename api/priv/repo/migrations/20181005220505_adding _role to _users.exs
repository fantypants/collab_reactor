defmodule :"Elixir.CollabReactor.Repo.Migrations.Adding Role to Users" do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :profession, :string
    end
  end
end
