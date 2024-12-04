defmodule Backend.Repo.Migrations.ModifyTableRecord do
  use Ecto.Migration

  def change do
    alter table(:records) do
      remove :record_datetime
    end
  end
end
