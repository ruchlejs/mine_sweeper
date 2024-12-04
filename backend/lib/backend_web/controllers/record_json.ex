defmodule BackendWeb.RecordJSON do
  alias Backend.Records.Record

  def show(%{record: record}) do
    %{data: data_record(record)}
  end

  defp data_record(%Record{} = record) do
    %{
      user: record.user_id,
      score: record.score,
      time: record.inserted_at,
    }
  end

end
