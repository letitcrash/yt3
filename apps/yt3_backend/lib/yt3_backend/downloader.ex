defmodule YT3.Downloader do
  use GenServer 

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: :downloader)
  end

  def init(_) do
    {:ok, %{}}
  end

  def get(provider, url) do
    case provider do
      :youtube ->
        GenServer.call(:downloader, {:download_youtube_audio, url})
      _-> 
        {:error, "#{provider} not supported"}
    end
  end
  
  def handle_call({:download_youtube_audio, url}, _from, state) do
    filepath = "/home/paul/tmp/yt3/" <> UUID.uuid1() <> ".mp3"

    args = ["--extract-audio", "--audio-format", "mp3", "-o", filepath, url]

    response = System.cmd("youtube-dl", args)

    {:reply, {:ok, response}, state} 
  end
end

