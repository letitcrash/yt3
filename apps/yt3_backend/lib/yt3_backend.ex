defmodule YT3 do
  use Application
  alias YT3.MetaFetcher
  alias YT3.Downloader

  def start(_type, _args) do
    YT3.Supervisor.start_link
  end

  def proceed_source(url, id) do
    with {:ok, provider, ext_id} <- process_url(url) do
      Task.start(fn ->
        with {:ok, meta} <- MetaFetcher.get(provider, ext_id) do
          Yt3UiWeb.Endpoint.broadcast! "sources:ready", "meta", %{id: id, meta: meta}
        end
      end) 

      Task.start(fn ->
        with {:ok, file} <- Downloader.get(provider, url) do
          uri = "/play?audio=#{file}"
          Yt3UiWeb.Endpoint.broadcast! "sources:ready", "file", %{id: id, file: uri}
        end
      end)
    end
  end

  defp process_url(url) do
    IO.inspect URI.parse(url)
    case URI.parse(url) do
      %URI{
        authority: "www.youtube.com",
        host: "www.youtube.com",
        path: "/watch",
        scheme: "https",
        query: "v=" <> id
      } -> 
        {:ok, :youtube, id}
        
      %URI{
        authority: "youtu.be",
        host: "youtu.be",
        path: id,
        scheme: "https"
      } -> 
        {:ok, :youtube, String.slice(id, 1..-1)}
        
      %URI{
        authority: "soundcloud.com",
        host: "soundcloud.com",
        path: path,
        scheme: "https"
      } -> 
        {:ok, :soundcloud, path}

      _ -> 
        {:error, "can not proceed with #{url}"}
    end
  end
end
