defmodule MatthewApiWeb.PolicyJSON do
  alias MatthewApi.Policies.Policy

  @doc """
  Renders a list of policies.
  """
  def index(%{policies: policies}) do
    %{data: for(policy <- policies, do: data(policy))}
  end

  @doc """
  Renders a single policy.
  """
  def show(%{policy: policy}) do
    %{data: data(policy)}
  end

  defp data(%Policy{} = policy) do
    %{
      id: policy.id,
      policy_number: policy.policy_number,
      policy_type: policy.policy_type,
      policy_duration: policy.policy_duration
    }
  end
end
