defmodule Yt3UiWeb.PageController do
  use Yt3UiWeb, :controller
  alias YT3.MetaFetcher
  alias YT3.Downloader

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def yt_handler(conn, %{"v" => youtube_id}) do
    #path = "/mnt/hdd/yt3/" <> file
    
    with {:ok, _meta} <- MetaFetcher.get(:youtube, youtube_id),
         {:ok, file} <- Downloader.get(:youtube, youtube_id)
    do        
      conn
      |> put_resp_content_type("audio/mpeg")
      |> send_file(200, file)
    end
  end

  def download(conn, %{"audio" => file}) do
    #path = "/mnt/hdd/yt3/" <> file
    conn
    |> send_file(200, file)
  end

  def play(conn, %{"audio" => file}) do
    #path = "/mnt/hdd/yt3/" <> file
  
    conn
    |> put_resp_content_type("audio/mpeg")
    |> send_file(200, file)
  end
end
