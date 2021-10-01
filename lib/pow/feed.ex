defmodule Pow.Feed do
  import Ecto.Query, warn: false

  alias Pow.{Repo, Pagination}
  alias Pow.Feed.{Post, Upvote, Comment}

  # Posts #

  def list_posts do
    Repo.all(Post)
  end

  def posts_ordered_by_upvotes(page \\ 1, per_page \\ 20) do
    query = from post in Post,
      left_join: up in assoc(post, :upvotes),
      preload: [:creator, comments: [:user]],
      group_by: post.id,
      select_merge: %{upvotes_count: count(up.id)},
      order_by: [desc: count(up.id)]
    
    query
      |> Pagination.page(page - 1, per_page: per_page)
  end

  def get_post(id) do
    query = from post in Post,
      left_join: up in assoc(post, :upvotes),
      where: post.id == ^id,
      preload: [:creator, comments: [:user]],
      group_by: post.id,
      select_merge: %{upvotes_count: count(up.id)}

    Repo.one(query)
  end

  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end

  # Upvotes #
  
  def list_upvotes do
    Repo.all(Upvote)
  end

  def get_upvote!(id), do: Repo.get!(Upvote, id)

  def create_upvote(attrs \\ %{}) do
    %Upvote{}
    |> Upvote.changeset(attrs)
    |> Repo.insert()
  end

  def update_upvote(%Upvote{} = upvote, attrs) do
    upvote
    |> Upvote.changeset(attrs)
    |> Repo.update()
  end

  def delete_upvote(%Upvote{} = upvote) do
    Repo.delete(upvote)
  end

  def change_upvote(%Upvote{} = upvote, attrs \\ %{}) do
    Upvote.changeset(upvote, attrs)
  end

  # Comments #

  def list_comments do
    Repo.all(Comment)
  end

  def get_comment!(id), do: Repo.get!(Comment, id)

  def create_comment(attrs \\ %{}) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end

  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end

  def change_comment(%Comment{} = comment, attrs \\ %{}) do
    Comment.changeset(comment, attrs)
  end
end
