defmodule YT3.Supervisor do
  use Supervisor
  alias YT3.Fetcher

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    children = [
      worker(Fetcher, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
