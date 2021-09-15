defmodule Pow.Repo do
  use Ecto.Repo,
    otp_app: :pow,
    adapter: Ecto.Adapters.Postgres
end
