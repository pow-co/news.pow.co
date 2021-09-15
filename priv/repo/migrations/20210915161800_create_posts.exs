defmodule Pow.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :url, :string
      add :creator_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:posts, [:creator_id])
  end
end
