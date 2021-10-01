defmodule PowWeb.CommentController do
  use PowWeb, :controller
  alias PowWeb.PostView
  alias Pow.Feed
  alias Pow.Feed.Comment

  def create(conn, %{"post_id" => post_id, "comment" => comment_params}) do
    post = Feed.get_post(post_id)

    case Feed.create_comment(comment_params) do
      {:ok, _comment} ->
        redirect(conn, to: Routes.post_path(conn, :show, post))
      {:error, comment} ->
        render(conn, PostView, "show.html", post: post, comment_changeset: comment)
    end
  end
end
