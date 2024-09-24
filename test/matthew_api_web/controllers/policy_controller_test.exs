defmodule MatthewApiWeb.PolicyControllerTest do
  use MatthewApiWeb.ConnCase

  import MatthewApi.PoliciesFixtures

  alias MatthewApi.Policies.Policy

  @create_attrs %{
    policy_duration: 42,
    policy_number: "some policy_number",
    policy_type: "some policy_type"
  }
  @update_attrs %{
    policy_duration: 43,
    policy_number: "some updated policy_number",
    policy_type: "some updated policy_type"
  }
  @invalid_attrs %{policy_duration: nil, policy_number: nil, policy_type: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all policies", %{conn: conn} do
      conn = get(conn, ~p"/api/policies")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create policy" do
    test "renders policy when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/policies", policy: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/policies/#{id}")

      assert %{
               "id" => ^id,
               "policy_duration" => 42,
               "policy_number" => "some policy_number",
               "policy_type" => "some policy_type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/policies", policy: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update policy" do
    setup [:create_policy]

    test "renders policy when data is valid", %{conn: conn, policy: %Policy{id: id} = policy} do
      conn = put(conn, ~p"/api/policies/#{policy}", policy: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/policies/#{id}")

      assert %{
               "id" => ^id,
               "policy_duration" => 43,
               "policy_number" => "some updated policy_number",
               "policy_type" => "some updated policy_type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, policy: policy} do
      conn = put(conn, ~p"/api/policies/#{policy}", policy: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete policy" do
    setup [:create_policy]

    test "deletes chosen policy", %{conn: conn, policy: policy} do
      conn = delete(conn, ~p"/api/policies/#{policy}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/policies/#{policy}")
      end
    end
  end

  defp create_policy(_) do
    policy = policy_fixture()
    %{policy: policy}
  end
end
