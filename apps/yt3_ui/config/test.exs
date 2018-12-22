use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :yt3_ui, Yt3UiWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :yt3_ui, Yt3Ui.Repo,
  username: "postgres",
  password: "postgres",
  database: "yt3_ui_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
