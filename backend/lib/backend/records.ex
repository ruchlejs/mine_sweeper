defmodule Backend.Records do
  alias Backend.Repo
  alias Backend.Records.Record
  alias Backend.Users.User

  import Ecto.Query

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

  def list_records() do
    Repo.all(Record)
  end

  def get_records!(user_id) do
    Repo.all(from r in Record, where: r.user_id == ^user_id)
  end
end
