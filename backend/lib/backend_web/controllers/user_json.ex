defmodule BackendWeb.UserJSON do
  alias Backend.Users.User
  alias BackendWeb.RecordJSON
  alias Backend.Records

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      username: user.username,
      password: user.password,
      record: Enum.map(user.records, &RecordJSON.data/1)
    }
  end
end
