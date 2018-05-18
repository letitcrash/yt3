defmodule Yt3Web.Media.Source do
  use Ecto.Schema
  import Ecto.Changeset


  schema "sources" do
    field :url, :string
    field :user_id, :id
    field :playlist_id, :id

    timestamps()
  end

  @doc false
  def changeset(source, attrs) do
    source
    |> cast(attrs, [:url])
    |> validate_required([:url])
    |> unique_constraint(:url)
  end
end
