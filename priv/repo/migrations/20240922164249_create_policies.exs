defmodule MatthewApi.Repo.Migrations.CreatePolicies do
  use Ecto.Migration

  def change do
    create table(:policies, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :policy_number, :string
      add :policy_type, :string
      add :policy_duration, :integer
      add :account_id, references(:accounts, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:policies, [:account_id])
  end
end
