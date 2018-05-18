defmodule Yt3Web.Media.Playlist do
  use Ecto.Schema
  import Ecto.Changeset


  schema "playlists" do
    field :name, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(playlist, attrs) do
    playlist
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
