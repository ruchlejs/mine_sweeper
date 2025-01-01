defmodule BackendWeb.Plugs.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :backend,
  module: Backend.Users.Auth.Guardian,
  error_handler: BackendWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
