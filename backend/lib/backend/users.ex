defmodule Backend.Users do
  alias Backend.Repo
  alias Backend.Users.User

  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def list_users() do
    Repo.all(User)
  end
end
