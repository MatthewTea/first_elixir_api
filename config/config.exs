# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :matthew_api,
  ecto_repos: [MatthewApi.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

# Configures the endpoint
config :matthew_api, MatthewApiWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: MatthewApiWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: MatthewApi.PubSub,
  live_view: [signing_salt: "LLcxvbKJ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :matthew_api, MatthewApiWeb.Auth.Guardian,
  issuer: "matthew_api",
  secret_key: "1AyUioofNNRLpTKKSyaQ5pB+oUSwPiKq8Ii6BvC9NdYMkSV2jqqW5UXrJZTWwGVJ"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :guardian, Guardian.DB,
  repo: MatthewApi.Repo,
  schema_name: "guardian_tokens",
  sweep_interval: 60

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
