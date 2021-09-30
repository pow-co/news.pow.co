defmodule Pow.Feed.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias Pow.Accounts.User
  alias Pow.Feed.Post

  schema "comments" do
    field :body, :string

    belongs_to :user, User
    belongs_to :post, Post

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :user_id, :post_id])
    |> validate_required([:body, :user_id, :post_id])
  end
end
