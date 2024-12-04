defmodule Backend.Repo.Migrations.ChangePasswordInEncryptedPassword do
  use Ecto.Migration

  def change do
    rename table(:users), :password, to: :encrypted_password
  end
end
