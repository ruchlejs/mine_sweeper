defmodule Backend.Repo.Migrations.ModifyUserTable do
  use Ecto.Migration

  def change do
    alter table (:users) do
      remove :record
    end
  end
end
