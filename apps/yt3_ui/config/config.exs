# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :yt3_ui,
  ecto_repos: [Yt3Ui.Repo]

# Configures the endpoint
config :yt3_ui, Yt3UiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "rRaWYH/qyMah1MjANhAjPQVbW4yv5Mvzx6RSQKTYF/BCLkIKdykeTt7jFTZn4/+y",
  render_errors: [view: Yt3UiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Yt3Ui.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
