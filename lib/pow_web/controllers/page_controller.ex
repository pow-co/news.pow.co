defmodule PowWeb.PageController do
  use PowWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
