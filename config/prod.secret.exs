use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :octograph, Octograph.Endpoint,
  secret_key_base: "MuxMWgq9KDryH7OOpV/l4g9A4wEmPf3tB2IoUkCtNOGt5prFhLmBKwoaskPgsaz6"

# Configure your database
# config :octograph, Octograph.Repo,
#   adapter: Ecto.Adapters.Postgres,
#   username: "postgres",
#   password: "postgres",
#   database: "octograph_prod"
