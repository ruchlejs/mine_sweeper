defmodule BackendWeb.UserController do
  use BackendWeb, :controller

  alias Backend.Users
  alias Backend.Users.User

  action_fallback BackendWeb.FallbackController

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, :index, users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user}")
      |> render(:show, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Users.get_user_with_record(id) do
      render(conn, :show_with_record, user: user)
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    with {:ok, user} <- Users.get_user(id),
         {:ok, new_user} <- Users.update_user(user, user_params) do
        render(conn, :show, user: new_user)
      end

  end

  def delete(conn, %{"id" => id}) do
    with {:ok, user} <- Users.get_user(id),
         {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
