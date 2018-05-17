defmodule Yt3WebWeb.PageController do
  use Yt3WebWeb, :controller

  def index(conn, _params) do
    song = YT3.Fetcher.get(:youtube, "mSxnoJThJwk")
    IO.inspect song
    render conn, "index.html", song: song
  end
end
