# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :exercise,
  ecto_repos: [Exercise.Repo]

# Configures the endpoint
config :exercise, ExerciseWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "87qAUQYGkljQHIIv6ox+6avFlTkq6cNBIJcJZOH8D6lyKZj7pwla0VxULE8TKMeU",
  render_errors: [view: ExerciseWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Exercise.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
