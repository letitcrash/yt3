defmodule YT3.MetaFetcher do
  use GenServer
  alias YT3.Fetcher.YoutubeMetaRequest

  def start_link() do
    GenServer.start_link(__MODULE__, :ok, name: :meta_fetcher)
  end

  def init(_) do
    {:ok, :nil}
  end

  def get(provider, id) do
    case provider do
      :youtube -> 
        GenServer.call(:meta_fetcher, {:get_youtube_meta, id})
      _-> 
        {:error, "#{provider} does not exist or not implemented yet"}
    end
  end

  def handle_call({:get_youtube_meta, id}, _from, state) do
    with {:ok, response} <- YoutubeMetaRequest.get(id) do
      {:reply, {:ok, response.body}, state}
    else
      err -> err
    end
  end
end


