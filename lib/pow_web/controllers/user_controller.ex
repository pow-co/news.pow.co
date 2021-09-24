defmodule PowWeb.UserController do
  use PowWeb, :controller
  alias Pow.{Accounts, Guardian}
  alias PowWeb.Services.HandhashService

  def login(conn, _params) do
    app_id = Application.fetch_env!(:pow, :handcash_app_id)
    redirect_url = Handkit.get_redirection_url(app_id)

    redirect(conn, external: redirect_url)
  end

  def handcash_callback(conn, %{"authToken" => auth_token}) do
    with {:ok, user_data} <- HandhashService.get_current_profile(auth_token),
        {:ok, user} <- Accounts.find_or_create_user_from_handhash(user_data) do
      
        conn
        |> Guardian.Plug.sign_in(user)
        |> assign(:current_user, user)
        |> redirect(to: Routes.feed_path(conn, :index))
    end
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> put_flash(:info, "Successfully Loged Out")
    |> redirect(to: Routes.feed_path(conn, :index))
  end
end
