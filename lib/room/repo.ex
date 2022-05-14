defmodule Room.Repo do
  use Ecto.Repo,
    otp_app: :room,
    adapter: Ecto.Adapters.Postgres
end
