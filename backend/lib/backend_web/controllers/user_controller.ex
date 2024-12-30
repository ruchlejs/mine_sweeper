defmodule BackendWeb.UserController do
  use BackendWeb, :controller

  alias Backend.Users
  alias Backend.Users.User

  action_fallback BackendWeb.FallbackController
  plug BackendWeb.Plugs.CorrectId when action in [:show, :update, :delete]

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

  def change_image(conn, %{"profile_picture" => picture, "user_id" => user_id}) do
    IO.inspect(picture)
    extension = Path.extname(picture.filename)
    allowed_extensions = [".jpeg", ".jpg", ".png"]

    if !Enum.member?(allowed_extensions,extension) do
      conn
      |> send_resp(:bad_request, "Wrong extension. We accept only #{Enum.join(allowed_extensions,", ")}")
      |> halt()
    end

    unique_name = "#{user_id}_profile#{extension}"
    destination = Path.join(:code.priv_dir(:backend),"/uploads/#{unique_name}")

    case File.cp(picture.path,destination) do
      :ok ->
        with {:ok, user} <- Users.get_user(user_id),
             {:ok, %User{} = update_user} <- Users.update_profile_picture(user,%{"profile_picture" => unique_name}) do

              send_resp(conn, :ok, "New picture upload with sucess with the name: #{unique_name}")
        else
          _ ->
            conn
            |> put_status(:internal_server_error)
            |> send_resp(:internal_server_error, "An unexpected error occurred")
        end

      {:error, reason} -> send_resp(conn, :bad_request, "reason: #{reason}")
    end
  end

  def show_image(conn, %{"user_id" => user_id}) do
    with {:ok, profile_picture} <-Users.get_profile_picture(user_id) do
      IO.inspect(profile_picture)
      upload_dir = Path.join(:code.priv_dir(:backend), "/uploads")
      source = Path.join(upload_dir, profile_picture)
      if File.exists?(source) do
        send_file(conn, :ok, source)
      else
        send_resp(conn,:not_found,"The picture #{profile_picture} is not in the server")
      end
    end
  end

  def delete_image(conn, %{"user_id" => user_id}) do
    with {:ok, user} <- Users.get_user(user_id),
         {:ok, _updated_user} <- Users.update_profile_picture(user, %{"profile_picture" => "default_profile.png"}) do
      send_resp(conn, :no_content, "")
    end
  end

end
