defmodule MatthewApi.Policies.Policy do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "policies" do
    field :policy_duration, :integer
    field :policy_number, :string
    field :policy_type, :string
    field :account_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(policy, attrs) do
    policy
    |> cast(attrs, [:policy_number, :policy_type, :policy_duration])
    |> validate_required([:policy_number, :policy_type, :policy_duration])
  end
end
