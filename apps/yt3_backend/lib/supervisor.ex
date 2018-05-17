defmodule YT3.Supervisor do
  use Supervisor
  alias YT3.MetaFetcher
  alias YT3.Downloader

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    children = [
      worker(MetaFetcher, []),
      worker(Downloader, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
