defmodule Exercise.ContractManager.ContractEntity do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "contract_entities" do
    field :contract_id, :integer
    field :entity_id, :integer

    timestamps()
  end

  def create_changeset(contract_entity, attrs) do
    contract_entity
    |> cast(attrs, [:contract_id, :entity_id])
  end
end
