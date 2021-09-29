defmodule PowWeb.FeedController do
  use PowWeb, :controller

  def index(conn, params) do
    {page, _} = Integer.parse(params["page"] || "1")
    
    posts = Pow.Feed.posts_ordered_by_upvotes(page)
    render(conn, "index.html", posts: posts)
  end
end
