defmodule PowWeb.FeedView do
  use PowWeb, :view

  def parse_host(url) do
    URI.parse(url).host
  end

  def time_ago(time) do
    Pow.DistanceOfTimeHelpers.time_ago_in_words(time)
  end
end
