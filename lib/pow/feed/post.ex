defmodule Pow.Feed.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pow.Accounts.User
  alias Pow.Feed.Upvote

  schema "posts" do
    field :title, :string
    field :url, :string
    
    belongs_to :creator, User
    has_many :upvotes, Upvote

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :url, :creator_id])
    |> validate_required([:title, :url, :creator_id])
  end
end
