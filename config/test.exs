use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :octograph, Octograph.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
# config :octograph, Octograph.Repo,
#   adapter: Ecto.Adapters.Postgres,
#   username: "postgres",
#   password: "postgres",
#   database: "octograph_test",
#   size: 1,
#   max_overflow: false

config :octograph,
  mongo_db: "octograph_test" 
