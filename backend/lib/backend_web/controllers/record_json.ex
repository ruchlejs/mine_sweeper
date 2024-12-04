defmodule BackendWeb.RecordJSON do
  alias Backend.Records.Record

  def show(%{record: record}) do
    %{data: data(record)}
  end

  def data(%Record{} = record) do
    %{
      user: record.user_id,
      score: record.score,
      time: record.inserted_at,
    }
  end

  def index(%{record: records}) do
    IO.inspect(records)
    %{
      data: for(record <- records, do: data(record))
    }
  end

end
