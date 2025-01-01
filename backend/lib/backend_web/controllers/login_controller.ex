defmodule BackendWeb.LoginController do
  use BackendWeb, :controller

  alias Backend.Accounts
  alias Backend.Users.Auth.Guardian

  def login(conn, %{"username" => username, "password" => password}) do
    with {:ok, user} <- Accounts.check_credentials(username, password) do
      {:ok, token, _claims} = Guardian.encode_and_sign(user)
      conn
      |> put_status(:ok)
      |> json(%{
      message: "Login successful",
      user: %{id: user.id, username: user.username},
      token: token
      })

    else
      {:error, :invalid_credentials} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Invalid credentials"})
    end
  end
end
