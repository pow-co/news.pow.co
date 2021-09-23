defmodule Pow.Accounts do
  import Ecto.Query, warn: false
  alias Pow.Repo

  alias Pow.Accounts.User

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def find_or_create_user_from_handhash(data \\ %{}) do
    user_attrs = %{
      handhash_id: get_in(data, ["public_profile", "id"]),
      email: get_in(data, ["private_profile", "email"]),
      phone_number: get_in(data, ["private_profile", "phone_number"]),
      username: get_in(data, ["public_profile", "handle"]),
      avatar_url: get_in(data, ["public_profile", "avatar_url"])
    }

    case Repo.get_by(User, %{handhash_id: user_attrs[:handhash_id]}) do
      nil -> create_user(user_attrs)
      user -> {:ok, user}
    end
  end
end
