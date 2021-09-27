# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :pow,
  ecto_repos: [Pow.Repo]

# Configures the endpoint
config :pow, PowWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "u0UOoDnGi4Q+ItiToKBohvXQrFYSTnQMk7jE3NrsKfI9RCnPzRs+nphf0X21O/VE",
  render_errors: [view: PowWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Pow.PubSub,
  live_view: [signing_salt: "KMoK0l7n"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :pow, Pow.Guardian,
  issuer: "pow",
  ttl: { 30, :days },
  secret_key: "L/4B9m6d8C5S6wX/JCPA6AR+bSvpHcJ5BS+i9U33wCNWZcBJebeKtQD8EnMTearZ"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
