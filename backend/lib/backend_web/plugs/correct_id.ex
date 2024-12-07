defmodule BackendWeb.Plugs.CorrectId do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn,opts) do
    id = conn.params["id"]

    if String.match?(id,~r/^\d+$/) do
      conn
    else
      conn
      |> put_status(:bad_request)
      |> Phoenix.Controller.put_view(BackendWeb.ErrorJSON)
      |> Phoenix.Controller.render(:"400")
    end
  end
end
