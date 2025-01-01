defmodule BackendWeb.ErrorHandler do

  import Plug.Conn

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, _reason}, _opts) do
    body = to_string(type)
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(401, body)
  end
end


# defmodule BackendWeb.ErrorHandler do
#   import Plug.Conn

#   def unauthenticated(conn, _params) do
#     conn
#     |> send_resp(:unauthorized, "Unauthorized")
#     |> halt()
#   end
# end


# defmodule BackendWeb.ErrorHandler do
#   import Plug.Conn

#   def auth_error(conn, {type, reason}, _opts) do
#     conn
#     |> put_status(:unauthorized)
#     |> json(%{error: "Authentication error", reason: reason, type: type})
#   end
# end
