defmodule Yt3WebWeb.SourceChannel do
  use Phoenix.Channel

  def join("sources:ready", _message, socket) do
    {:ok, socket}
  end

  # def get(id, url) do
  #   meta_task = YT3.get_meta(url)
  #   proceed_meta(meta_task, id)

  #   download_task = YT3.get_audio_file(url)
  #   proceed_file(download_task, id)
  # end

  # def proceed_meta(meta_task, id) do
  #   case Task.await(meta_task) do
  #     {:ok, meta} ->
  #       broadcast! socket, "meta", %{id: id, meta: meta}
  #     _err ->
  #       {:reply, :error, socket}
  #   end
  # end
  # 
  # def proceed_file(download_task, id) do
  #   case Task.await(download_task) do
  #     {:ok, _json} ->
  #       broadcast! socket, "file", %{id: id, file: file}
  #     _err ->
  #       {:reply, :error, socket}
  #   end
  # end
end
