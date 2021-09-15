defmodule Pow.Feed.Upvote do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pow.Accounts.User
  alias Pow.Feed.Post

  schema "upvotes" do
    belongs_to :user, User
    belongs_to :post, Post

    timestamps()
  end

  @doc false
  def changeset(upvote, attrs) do
    upvote
    |> cast(attrs, [])
    |> validate_required([])
  end
end
