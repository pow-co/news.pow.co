defmodule Pow.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pow.Feed.Post

  schema "users" do
    field :about, :string
    field :username, :string
    field :email, :string
    field :phone_number, :string
    field :avatar_url, :string
    field :handhash_id, :string

    has_many :posts, Post, foreign_key: 'creator_id'

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :about, :email, :phone_number, :avatar_url, :handhash_id])
    |> validate_required([:username])
  end
end
