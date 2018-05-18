defmodule Yt3WebWeb.PlaylistController do
  use Yt3WebWeb, :controller

  alias Yt3Web.Media
  alias Yt3Web.Media.Playlist

  def index(conn, _params) do
    playlists = Media.list_playlists()
    render(conn, "index.html", playlists: playlists)
  end

  def new(conn, _params) do
    changeset = Media.change_playlist(%Playlist{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"playlist" => playlist_params}) do
    case Media.create_playlist(playlist_params) do
      {:ok, playlist} ->
        conn
        |> put_flash(:info, "Playlist created successfully.")
        |> redirect(to: playlist_path(conn, :show, playlist))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    playlist = Media.get_playlist!(id)
    render(conn, "show.html", playlist: playlist)
  end

  def edit(conn, %{"id" => id}) do
    playlist = Media.get_playlist!(id)
    changeset = Media.change_playlist(playlist)
    render(conn, "edit.html", playlist: playlist, changeset: changeset)
  end

  def update(conn, %{"id" => id, "playlist" => playlist_params}) do
    playlist = Media.get_playlist!(id)

    case Media.update_playlist(playlist, playlist_params) do
      {:ok, playlist} ->
        conn
        |> put_flash(:info, "Playlist updated successfully.")
        |> redirect(to: playlist_path(conn, :show, playlist))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", playlist: playlist, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    playlist = Media.get_playlist!(id)
    {:ok, _playlist} = Media.delete_playlist(playlist)

    conn
    |> put_flash(:info, "Playlist deleted successfully.")
    |> redirect(to: playlist_path(conn, :index))
  end
end
