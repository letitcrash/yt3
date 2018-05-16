defmodule YT3.Fetcher do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, :ok, name: :fetcher)
  end

  def init(_) do
    {:ok, :nil}
  end

  def get(provider, id) do
    case provider do
      :youtube -> 
        GenServer.call(:fetcher, {:get_youtube_song, id})
      _-> 
        {:error, "#{provider} is not exist or not implemented yet"}
    end
  end

  def handle_call({:get_youtube_song, id}, _from, state) do
    {:reply, id, state}
  end
end


