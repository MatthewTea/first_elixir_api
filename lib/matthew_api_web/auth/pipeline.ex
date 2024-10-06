defmodule MatthewApiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :matthew_api,
    module: MatthewApiWeb.Auth.Guardian,
    error_handler: MatthewApiWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
