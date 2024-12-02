defmodule Backend.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Backend.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        password: "some password",
        record: 42,
        username: "some username"
      })
      |> Backend.Users.create_user()

    user
  end
end
