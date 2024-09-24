defmodule MatthewApiWeb.PolicyController do
  use MatthewApiWeb, :controller

  alias MatthewApi.Policies
  alias MatthewApi.Policies.Policy

  action_fallback MatthewApiWeb.FallbackController

  def index(conn, _params) do
    policies = Policies.list_policies()
    render(conn, :index, policies: policies)
  end

  def create(conn, %{"policy" => policy_params}) do
    with {:ok, %Policy{} = policy} <- Policies.create_policy(policy_params) do
      conn
      |> put_status(:created)
      |> render(:show, policy: policy)
    end
  end

  def show(conn, %{"id" => id}) do
    policy = Policies.get_policy!(id)
    render(conn, :show, policy: policy)
  end

  def update(conn, %{"id" => id, "policy" => policy_params}) do
    policy = Policies.get_policy!(id)

    with {:ok, %Policy{} = policy} <- Policies.update_policy(policy, policy_params) do
      render(conn, :show, policy: policy)
    end
  end

  def delete(conn, %{"id" => id}) do
    policy = Policies.get_policy!(id)

    with {:ok, %Policy{}} <- Policies.delete_policy(policy) do
      send_resp(conn, :no_content, "")
    end
  end
end
