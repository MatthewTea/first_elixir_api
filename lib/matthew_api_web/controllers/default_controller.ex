defmodule MatthewApiWeb.DefaultController do
  use MatthewApiWeb, :controller

  def index(conn, _params) do
    text(conn, "The first matthew api in elixir is LIFE -#{Mix.env()}")
  end
end
