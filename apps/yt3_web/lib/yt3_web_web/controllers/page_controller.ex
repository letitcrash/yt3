defmodule Yt3WebWeb.PageController do
  use Yt3WebWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
