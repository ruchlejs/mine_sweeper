defmodule BackendWeb.LoginController do
  use BackendWeb, :controller

  alias Backend.Accounts
  alias BackendWeb.Auth.Guardian

  def login(conn, %{"username" => username, "password" => password}) do
    with {:ok, user} <- Accounts.check_credentials(username, password) do
      case Guardian.encode_and_sign(user) do
        {:ok, token, _claims} ->
          json(conn, %{token: token, user_id: user.id})

        {:error, :secret_not_found} ->
          conn
          |> put_status(:unauthorized)
          |> json(%{error: "The secret key is missing"})

        {:error, reason} ->
          conn
          |> put_status(:internal_server_error)
          |> json(%{error: "Unknown error: #{inspect(reason)}"})
      end

    else
      {:error, :invalid_credentials} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Invalid credentials"})
    end
  end
end
