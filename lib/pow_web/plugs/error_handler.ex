defmodule PowWeb.Plugs.ErrorHandler do
  import Plug.Conn
  alias PowWeb.Router.Helpers, as: Routes


  def auth_error(conn, {type, _reason}, _opts) do
    body = to_string(type)

    case body do
      "unauthenticated" ->
        conn
          |> Phoenix.Controller.redirect(to: Routes.user_path(conn, :login))
      _reason_type ->
        conn
          |> put_resp_content_type("text/plain")
          |> send_resp(401, body)
    end
  end
end
