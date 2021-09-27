defmodule PowWeb.Plugs.LoadCurrentUser do
  import Plug.Conn

  def init(config), do: config

  def call(conn, _) do
    case Guardian.Plug.authenticated?(conn) do
      true ->
        assign(conn, :current_user, Guardian.Plug.current_resource(conn))
      false ->
        conn
    end
  end
end
