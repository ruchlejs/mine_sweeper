defmodule BackendWeb.Plugs.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :backend,
    error_handler: BackendWeb.ErrorHandler

  plug Guardian.Plug.VerifyHeader, scheme: "Bearer"
  plug Guardian.Plug.LoadResource
end
