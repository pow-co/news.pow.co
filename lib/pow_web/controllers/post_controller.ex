defmodule PowWeb.PostController do
  use PowWeb, :controller
  alias Pow.Feed
  alias Pow.Feed.Post

  def new(conn, _params) do
    post = Post.changeset(%Post{}, %{})
    render(conn, "new.html", post: post, errors: false, current_user: current_user(conn))
  end

  def create(conn, %{"post" => post_params}) do
    case Feed.create_post(post_params) do
      {:ok, _post} ->
        conn
        |> redirect(to: Routes.feed_path(conn, :index))
      {:error, post} ->
        conn
        |> render("new.html", post: post, errors: post.errors, current_user: current_user(conn))
    end
  end

  def current_user(conn), do: Guardian.Plug.current_resource(conn)
end
