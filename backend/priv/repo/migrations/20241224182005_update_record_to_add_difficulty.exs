defmodule Backend.Repo.Migrations.UpdateRecordToAddDifficulty do
  use Ecto.Migration

  def change do
    alter table(:records) do
      add :difficulty, :string
    end
  end
end
