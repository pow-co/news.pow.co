defmodule PowWeb.FeedController do
  use PowWeb, :controller

  def index(conn, _params) do
    posts = Pow.Feed.posts_ordered_by_upvotes
    render(conn, "index.html", posts: posts)
  end
end
