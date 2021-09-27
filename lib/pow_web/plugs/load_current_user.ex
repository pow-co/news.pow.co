defmodule PowWeb.Plugs.LoadCurrentUser do
  import Plug.Conn

  def init(config), do: config

  def call(conn, _) do
    assign(conn, :current_user, Guardian.Plug.current_resource(conn))
  end
end
