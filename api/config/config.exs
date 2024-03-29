# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :collab_reactor,
  ecto_repos: [CollabReactor.Repo]

# Configures the endpoint
config :collab_reactor, CollabReactorWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "tnf75ROfDfZ1Tedb+FhAGo7G0JzPnRx2yYqZHTsNv3eFUEF8dnpheHtSeo/K6Eex",
  render_errors: [view: CollabReactorWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CollabReactor.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  issuer: "CollabReactor",
  ttl: {30, :days},
  verify_issuer: true,
  secret_key: "LyfHhEqsM7ggO8gshJcum0YWHmq1UFQfk04L3q3pfS2Ht52IUZ6jTZe40DCGTSbY",

  serializer: CollabReactor.Services.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
