defmodule PowWeb.Plugs.MaybeAuthPipeline do
  use Guardian.Plug.Pipeline, 
    otp_app: :pow,
    module: Pow.Guardian,
    error_handler: PowWeb.Plugs.ErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.LoadResource, allow_blank: true
  plug PowWeb.Plugs.LoadCurrentUser
end
