defmodule Backend.Records do
  alias Backend.Repo
  alias Backend.Records.Record
  alias Backend.Users.User

  import Ecto.Query

  def create_record(user_id, attrs) do

    with %User{} <- Repo.get(User, user_id) do
      attrs = Map.put(attrs, "user_id", user_id)

      %Record{}
      |> Record.changeset(attrs)
      |> Repo.insert()
    else
      nil ->
        {:error, :not_found}
    end
  end

  def list_records() do
    Repo.all(Record)
  end

  def get_records!(user_id) do
    with %User{} <- Repo.get(User, user_id) do
      {:ok, Repo.all(from r in Record, where: r.user_id == ^user_id)}
    else
      nil -> {:error, :not_found}
    end
  end
end
