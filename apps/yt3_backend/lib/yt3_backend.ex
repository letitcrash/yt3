defmodule YT3 do
  use Application
  alias YT3.MetaFetcher
  alias YT3.Downloader

  def start(_type, _args) do
    YT3.Supervisor.start_link
  end
  
  @spec get_meta(String.t) :: %Task{}
  def get_meta(url) do
    with {:ok, provider, id} <- process_url(url) do
      Task.async(fn ->
        MetaFetcher.get(provider, id)
      end)
    else
      err -> err
    end
  end

  def get_audio_file(url) do
    with {:ok, provider, _id} <- process_url(url) do
      Task.async(fn ->
        Downloader.get(provider, url)
      end)
    else
      err -> err
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
