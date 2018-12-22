defmodule YT3 do
  use Application
  alias YT3.MetaFetcher
  alias YT3.Downloader

  def start(_type, _args) do
    YT3.Supervisor.start_link
  end

  def proceed_source(url, id) do
    IO.inspect url
    with {:ok, provider, ext_id} <- process_url(url) do
      Task.start(fn ->
        with {:ok, meta} <- MetaFetcher.get(provider, ext_id) do
          Yt3UiWeb.Endpoint.broadcast! "sources:ready", "meta", %{id: id, meta: meta}
        end
      end) 

      Task.start(fn ->
        with {:ok, file} <- Downloader.get(provider, url) do
          Yt3UiWeb.Endpoint.broadcast! "sources:ready", "file", %{id: id, file: file}
        end
      end)
    end
  end

  defp process_url(url) do
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
