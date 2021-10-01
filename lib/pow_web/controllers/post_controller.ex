defmodule PowWeb.PostController do
  use PowWeb, :controller
  alias PowWeb.ErrorView
  alias Pow.Feed
  alias Pow.Feed.Post

  def new(conn, _params) do
    post = Post.changeset(%Post{}, %{})
    render(conn, "new.html", post: post, errors: false)
  end

  def create(conn, %{"post" => post_params}) do
    case Feed.create_post(post_params) do
      {:ok, _post} ->
        conn
        |> redirect(to: Routes.feed_path(conn, :index))
      {:error, post} ->
        conn
        |> render("new.html", post: post, errors: post.errors)
    end
  end

  def show(conn, %{"id" => post_id}) do
    post = Feed.get_post(post_id)

    case post do
      nil ->
        render(conn, ErrorView, "404.html")
      post ->
        render(conn, "show.html", post: post, errors: false)
    end
  end
end
