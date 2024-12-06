defmodule Backend.Repo.Migrations.AlterUserForUniqueUsername do
  use Ecto.Migration

  def change do
    create unique_index(:users, [:username])
  end
end
