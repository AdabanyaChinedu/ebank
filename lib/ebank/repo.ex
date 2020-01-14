defmodule Ebank.Repo do
  use Ecto.Repo,
    otp_app: :ebank,
    adapter: Ecto.Adapters.Postgres
end
