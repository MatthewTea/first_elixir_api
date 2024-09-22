defmodule MatthewApi.Repo do
  use Ecto.Repo,
    otp_app: :matthew_api,
    adapter: Ecto.Adapters.Postgres
end
