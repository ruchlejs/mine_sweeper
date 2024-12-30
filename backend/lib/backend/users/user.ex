defmodule Backend.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :password, :string, virtual: true
    field :encrypted_password, :string
    field :profile_picture, :string, default: "default_profile.jpg"

    has_many :records, Backend.Records.Record

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password, :profile_picture])
    |> validate_required([:username, :password])
    |> unique_constraint(:username)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case get_change(changeset, :password) do
      nil -> changeset
      password ->
        hash_password = Bcrypt.hash_pwd_salt(password)
        put_change(changeset, :encrypted_password, hash_password)
    end
  end

  def profile_picture_changeset(user, attrs) do
    user
    |> cast(attrs, [:profile_picture])
    |> validate_required([:profile_picture])
  end
end
