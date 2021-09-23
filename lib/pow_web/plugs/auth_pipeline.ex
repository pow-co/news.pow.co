defmodule PowWeb.Plugs.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :pow,
    error_handler: PowWeb.Plugs.ErrorHandler,
    module: Pow.Auth.Guardian

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
end
