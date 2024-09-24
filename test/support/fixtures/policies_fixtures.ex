defmodule MatthewApi.PoliciesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MatthewApi.Policies` context.
  """

  @doc """
  Generate a policy.
  """
  def policy_fixture(attrs \\ %{}) do
    {:ok, policy} =
      attrs
      |> Enum.into(%{
        policy_duration: 42,
        policy_number: "some policy_number",
        policy_type: "some policy_type"
      })
      |> MatthewApi.Policies.create_policy()

    policy
  end
end
