defmodule Backend.Records.Record do
  use Ecto.Schema
  import Ecto.Changeset

  schema "records" do
    belongs_to :user, Backend.Users.User
    field :score, :integer
    field :record_datetime, :utc_datetime

    timestamps(type: :utc_datetime)
  end

  def changeset(record, attrs) do
    record
    |> cast(attrs, [:user_id, :score, :record_datetime])
    |>validate_required([:user_id, :score, :record_datetime])
    |>validate_number(:score, greater_than: 0)
  end
end
