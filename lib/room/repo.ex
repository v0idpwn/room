defmodule Room.Repo do
  use Ecto.Repo,
    otp_app: :room,
    adapter: Vax.Adapter
end
