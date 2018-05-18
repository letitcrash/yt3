defmodule Yt3Web.Repo.Migrations.CreateSources do
  use Ecto.Migration

  def change do
    create table(:sources) do
      add :url, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :playlist_id, references(:playlists, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:sources, [:url])
    create index(:sources, [:user_id])
    create index(:sources, [:playlist_id])
  end
end
