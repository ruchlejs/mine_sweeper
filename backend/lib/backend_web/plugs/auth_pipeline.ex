defmodule BackendWeb.Plugs.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :backend,
  module: BackendWeb.Auth.Guardian,
  error_handler: BackendWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
