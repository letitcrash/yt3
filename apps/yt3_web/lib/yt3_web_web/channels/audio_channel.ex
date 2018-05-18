defmodule Yt3WebWeb.AudioChannel do
  use Phoenix.Channel

  def join("audio:ready", _message, socket) do
    {:ok, socket}
  end

  def handle_in("new_url", %{"url" => url}, socket) do
    #save in db

    
    meta_task = YT3.get_meta(url)
    proceed_meta(meta_task, socket)

    download_task = YT3.get_audio_file(url)
    proceed_file(download_task, socket)
    {:noreply, socket}
  end

  def proceed_meta(meta_task, socket) do
    case Task.await(meta_task) do
      {:ok, meta} ->
        push socket, "meta", %{ :payload => meta}
      _err ->
        {:reply, :error, socket}
    end
  end
  
  def proceed_file(download_task, socket) do
    case Task.await(download_task) do
      {:ok, _json} ->
        push socket, "file", %{ :payload => :ok}
      _err ->
        {:reply, :error, socket}
    end
  end
end

