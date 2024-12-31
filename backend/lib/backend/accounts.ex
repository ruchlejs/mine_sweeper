defmodule Backend.Accounts do

  alias Backend.Repo
  alias Backend.Users.User

  def check_credentials(username,password) do
    case Repo.get_by(User, username: username) do
      nil ->
        Bcrypt.no_user_verify()
        {:error, :invalid_credentials}

      user ->
        if Bcrypt.verify_pass(password, user.encrypted_password) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end
end
