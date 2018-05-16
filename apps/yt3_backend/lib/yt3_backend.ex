defmodule YT3 do
  use Application

  def start(_type, _args) do
    YT3.Supervisor.start_link
  end
end
