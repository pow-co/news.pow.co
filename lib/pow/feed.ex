defmodule Pow.Feed do
  import Ecto.Query, warn: false

  alias Pow.Repo
  alias Pow.Feed.{Post, Upvote}

  # Posts #

  def list_posts do
    Repo.all(Post)
  end

  def get_post!(id), do: Repo.get!(Post, id)

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
end