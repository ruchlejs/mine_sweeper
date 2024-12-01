defmodule Backend.Users.user do

  schema "users" do
    field :username, :string
    field :password, :string
    field :record, :integer, default: 0

    timestamps()
  end

  def changeset(user,attrs) do
    user
    |>cast(attrs, [:username, :password, :record])
    |>validate_required([:username, :password])
  end
end
