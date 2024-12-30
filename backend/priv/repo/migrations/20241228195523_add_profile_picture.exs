defmodule Backend.Repo.Migrations.AddProfilePicture do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :profile_picture, :string, default: "default_profile.jpg"
    end

  end
end
