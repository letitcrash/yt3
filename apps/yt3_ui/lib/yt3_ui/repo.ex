defmodule Yt3Ui.Repo do
  use Ecto.Repo,
    otp_app: :yt3_ui,
    adapter: Ecto.Adapters.Postgres
end
