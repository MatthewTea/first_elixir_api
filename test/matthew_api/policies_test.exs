defmodule MatthewApi.PoliciesTest do
  use MatthewApi.DataCase

  alias MatthewApi.Policies

  describe "policies" do
    alias MatthewApi.Policies.Policy

    import MatthewApi.PoliciesFixtures

    @invalid_attrs %{policy_duration: nil, policy_number: nil, policy_type: nil}

    test "list_policies/0 returns all policies" do
      policy = policy_fixture()
      assert Policies.list_policies() == [policy]
    end

    test "get_policy!/1 returns the policy with given id" do
      policy = policy_fixture()
      assert Policies.get_policy!(policy.id) == policy
    end

    test "create_policy/1 with valid data creates a policy" do
      valid_attrs = %{policy_duration: 42, policy_number: "some policy_number", policy_type: "some policy_type"}

      assert {:ok, %Policy{} = policy} = Policies.create_policy(valid_attrs)
      assert policy.policy_duration == 42
      assert policy.policy_number == "some policy_number"
      assert policy.policy_type == "some policy_type"
    end

    test "create_policy/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Policies.create_policy(@invalid_attrs)
    end

    test "update_policy/2 with valid data updates the policy" do
      policy = policy_fixture()
      update_attrs = %{policy_duration: 43, policy_number: "some updated policy_number", policy_type: "some updated policy_type"}

      assert {:ok, %Policy{} = policy} = Policies.update_policy(policy, update_attrs)
      assert policy.policy_duration == 43
      assert policy.policy_number == "some updated policy_number"
      assert policy.policy_type == "some updated policy_type"
    end

    test "update_policy/2 with invalid data returns error changeset" do
      policy = policy_fixture()
      assert {:error, %Ecto.Changeset{}} = Policies.update_policy(policy, @invalid_attrs)
      assert policy == Policies.get_policy!(policy.id)
    end

    test "delete_policy/1 deletes the policy" do
      policy = policy_fixture()
      assert {:ok, %Policy{}} = Policies.delete_policy(policy)
      assert_raise Ecto.NoResultsError, fn -> Policies.get_policy!(policy.id) end
    end

    test "change_policy/1 returns a policy changeset" do
      policy = policy_fixture()
      assert %Ecto.Changeset{} = Policies.change_policy(policy)
    end
  end
end
