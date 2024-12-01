defmodule Backend.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :password, :string, null: false
      add :record, :integer, default: 0

      timestamps()
    end
  end
end
