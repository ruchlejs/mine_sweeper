defmodule Backend.Records do
  alias Backend.Repo
  alias Backend.Records.Record
  alias Backend.Users.User

  def create_record(user_id, attrs) do
    user = Repo.get(User, user_id)

    if user do
      attrs = Map.put(attrs, "user_id", user_id)

      %Record{}
      |> Record.changeset(attrs)
      |> Repo.insert()
    else
      {:error, "User not found"}
    end
  end
end
