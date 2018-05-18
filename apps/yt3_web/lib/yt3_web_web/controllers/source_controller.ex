defmodule Yt3WebWeb.SourceController do
  use Yt3WebWeb, :controller

  alias Yt3Web.Media
  alias Yt3Web.Media.Source

  def index(conn, _params) do
    sources = Media.list_sources()
    render(conn, "index.html", sources: sources)
  end

  def new(conn, _params) do
    changeset = Media.change_source(%Source{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"source" => source_params}) do
    case Media.create_source(source_params) do
      {:ok, source} ->
        conn
        |> put_flash(:info, "Source created successfully.")
        |> redirect(to: source_path(conn, :show, source))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    source = Media.get_source!(id)
    render(conn, "show.html", source: source)
  end

  def edit(conn, %{"id" => id}) do
    source = Media.get_source!(id)
    changeset = Media.change_source(source)
    render(conn, "edit.html", source: source, changeset: changeset)
  end

  def update(conn, %{"id" => id, "source" => source_params}) do
    source = Media.get_source!(id)

    case Media.update_source(source, source_params) do
      {:ok, source} ->
        conn
        |> put_flash(:info, "Source updated successfully.")
        |> redirect(to: source_path(conn, :show, source))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", source: source, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    source = Media.get_source!(id)
    {:ok, _source} = Media.delete_source(source)

    conn
    |> put_flash(:info, "Source deleted successfully.")
    |> redirect(to: source_path(conn, :index))
  end
end
