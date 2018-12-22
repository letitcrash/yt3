defmodule Yt3UiWeb.SourcesChannelTest do
  use Yt3UiWeb.ChannelCase

  setup do
    {:ok, _, socket} =
      socket(Yt3UiWeb.UserSocket, "user_id", %{some: :assign})
      |> subscribe_and_join(Yt3UiWeb.SourcesChannel, "sources:lobby")

    {:ok, socket: socket}
  end

  test "ping replies with status ok", %{socket: socket} do
    ref = push socket, "ping", %{"hello" => "there"}
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "shout broadcasts to sources:lobby", %{socket: socket} do
    push socket, "shout", %{"hello" => "all"}
    assert_broadcast "shout", %{"hello" => "all"}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "broadcast", %{"some" => "data"}
    assert_push "broadcast", %{"some" => "data"}
  end
end
