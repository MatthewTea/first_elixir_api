defmodule MatthewApiWeb.Router do
  use MatthewApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MatthewApiWeb do
    pipe_through :api
    get "/", DefaultController, :index
  end
end
