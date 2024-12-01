defmodule BackendWeb.UserController do
  use BackendWeb, :controller

  alias Backend.Users

  def create(conn, %{"user" => user_params}) do
    case Backend.Users.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> json(%{message: "User created successfully", user: user})
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: "Failed to create user", changeset: changeset})
    end
  end


  def index(conn, _params) do
    users = Users.list_users()

    conn
    |> put_status(:ok)
    |> json(%{users: users})
  end


end
