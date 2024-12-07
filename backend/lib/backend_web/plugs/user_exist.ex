defmodule BackendWeb.Plugs.UserExist do
  import Plug.Conn
  alias Backend.Repo
  alias Backend.Users.User

  def init(opts), do: opts

  def call(conn, _opt) do
    user_id = conn.params["user_id"]

    case Repo.get(User,user_id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> Phoenix.Controller.put_view(BackendWeb.ErrorJSON)
        |> Phoenix.Controller.render(:"404")
      user ->
        assign(conn,:user,user)
    end
  end
end
