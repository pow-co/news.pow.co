defmodule Pow.Repo.Migrations.AddNewFieldsToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :email, :string
      add :phone_number, :string
      add :avatar_url, :string
      add :handhash_id, :string
    end
  end
end
