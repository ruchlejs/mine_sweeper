defmodule Backend.Repo.Migrations.CreateRecordTable do
  use Ecto.Migration

  def change do
    create table(:records) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :score, :integer
      add :record_datetime, :utc_datetime

      timestamps()
    end

    create index(:records, [:user_id])
  end
end
