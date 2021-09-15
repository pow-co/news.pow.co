defmodule Pow.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pow.Feed.Post

  schema "users" do
    field :about, :string
    field :username, :string

    has_many :posts, Post

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :about])
    |> validate_required([:username])
  end
end
