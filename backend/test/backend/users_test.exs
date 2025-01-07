defmodule Backend.UsersTest do
  use Backend.DataCase

  alias Backend.Users

  describe "users" do
    alias Backend.Users.User

    import Backend.UsersFixtures

    @invalid_attrs %{record: nil, username: nil, password: nil}

    test "list_users/0 returns all users" do
      user =
        user_fixture()
        |>Repo.preload(:records)

      actual_users = Users.list_users() |> Enum.map(&Map.drop(&1, [:password]))
      expected_users = [user] |> Enum.map(&Map.drop(&1, [:password]))

      assert actual_users == expected_users
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      retrieve_user = Users.get_user!(user.id)
      assert Map.take(retrieve_user,[:id,:username,:encrypted_password,:profile_picture,:inserted_at,:updated_at]) ==
             Map.take(user,[:id,:username,:encrypted_password,:profile_picture,:inserted_at,:updated_at])
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{username: "some username", password: "some password"}

      assert {:ok, %User{} = user} = Users.create_user(valid_attrs)
      assert user.username == "some username"
      assert user.password == "some password"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{username: "some updated username", password: "some updated password"}

      assert {:ok, %User{} = user} = Users.update_user(user, update_attrs)
      assert user.username == "some updated username"
      assert user.password == "some updated password"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      retrieve_user = Users.get_user!(user.id)
      assert Map.take(user,[:id,:username,:encrypted_password,:profile_picture,:inserted_at,:updated_at]) ==
             Map.take(retrieve_user,[:id,:username,:encrypted_password,:profile_picture,:inserted_at,:updated_at])
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
