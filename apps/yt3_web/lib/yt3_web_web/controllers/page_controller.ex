defmodule Yt3WebWeb.PageController do
  use Yt3WebWeb, :controller

  def index(conn, _params) do
    task = YT3.get_meta("https://www.youtube.com/watch?v=AQ4edkthGNc")
    song = Task.await(task)
    IO.inspect song
    render conn, "index.html", song: song
  end
end
