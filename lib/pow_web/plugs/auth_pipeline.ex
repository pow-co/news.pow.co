defmodule PowWeb.Plugs.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :pow,
    module: Pow.Guardian,
    error_handler: PowWeb.Plugs.ErrorHandler

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, allow_blank: true
end
