defmodule BackendWeb.LoginController do
  use BackendWeb, :controller

  alias Backend.Accounts
  alias BackendWeb.Auth.Guardian

  def login(conn, %{"username" => username, "password" => password}) do
    with {:ok, user} <- Accounts.check_credentials(username, password) do
      IO.puts("test")
      case Guardian.encode_and_sign(user) do
        {:ok, token, _claims} ->
          # Votre logique pour gérer un token valide
          json(conn, %{token: token, user_id: user.id})

        {:error, :secret_not_found} ->
          # Logique pour gérer l'erreur de clé secrète manquante
          conn
          |> put_status(:unauthorized)
          |> json(%{error: "La clé secrète est manquante"})

        {:error, reason} ->
          # Logique pour gérer d'autres erreurs
          conn
          |> put_status(:internal_server_error)
          |> json(%{error: "Erreur inconnue: #{inspect(reason)}"})
      end

    else
      {:error, :invalid_credentials} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Invalid credentials"})
    end
  end
end
