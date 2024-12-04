defmodule BackendWeb.RecordController do
  use BackendWeb, :controller

  alias Backend.Users
  alias Backend.Records
  alias Backend.Records.Record

  action_fallback BackendWeb.FallbackController

  def create(conn, %{"user_id" => user_id, "record" => new_record}) do
    with {:ok, %Record{} = record} <- Records.create_record(user_id, new_record) do
      conn
      |> put_status(:created)
      |> render(:show, record: record)
    end
  end
end
