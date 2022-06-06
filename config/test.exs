import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :room, Room.Repo, hostname: "localhost", port: 8087

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :room, RoomWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "jnBYyLbqdTg/FELM9YO5f7kXQq/itvRcaDSltL+ZgUj8PGTtmS9yqWFGAyZ6MVHc",
  server: false

# In test we don't send emails.
config :room, Room.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
