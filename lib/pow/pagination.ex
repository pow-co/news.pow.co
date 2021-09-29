defmodule Pow.Pagination do
  import Ecto.Query
  alias Pow.Repo
  #
  # ## Example
  #
  #    Pow.Feed.Post
  #    |> order_by(desc: :inserted_at)
  #    |> Pagination.page(0, per_page: 10)
  #
  def page(query, page, per_page: per_page) when is_nil(page) do
    page(query, 0, per_page: per_page)
  end

  def page(query, page, per_page: per_page) when is_binary(page) do
    page = String.to_integer(page)
    page(query, page, per_page: per_page)
  end

  def page(query, page, per_page: per_page) do
    count = per_page + 1
    result = query
             |> limit(^count)
             |> offset(^(page*per_page))
             |> Repo.all
    has_next = (length(result) == count)
    has_prev = page > 0
    page = %{
      has_next: has_next,
      has_prev: has_prev,
      prev_page: page - 1,
      next_page: page + 1,
      page: page,
      list: Enum.slice(result, 0, count-1)
    }
  end
end
