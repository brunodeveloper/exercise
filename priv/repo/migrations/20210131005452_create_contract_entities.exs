defmodule Exercise.Repo.Migrations.CreateContractEntities do
  use Ecto.Migration

  def change do
    create table(:contract_entities) do
      add :contract_id, references(:contracts), null: false
      add :entity_id, references(:entities), null: false

      timestamps()
    end

    create unique_index(:contract_entities, [:contract_id, :entity_id],
             name: :unique_contract_entities_index
           )
  end
end
