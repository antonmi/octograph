use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :octograph, Octograph.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

import_config "database_test.exs"
