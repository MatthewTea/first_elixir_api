defmodule MatthewApiWeb.Auth.ErrorResponse.Unauthorized do
  defexception message: "Unauthorized", plug_status: 401
end

defmodule MatthewApiWeb.Auth.ErrorResponse.Forbidden do
  defexception message: "You do not have the access to this resource.", plug_status: 403
end

defmodule MatthewApiWeb.Auth.ErrorResponse.NotFound do
  defexception message: "Not Found", plug_status: 404
end
