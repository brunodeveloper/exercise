defmodule Exercise.ContractManager.ContractEntity do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "contract_entities" do
    field :contract_id, :integer
    field :entity_id, :integer

    timestamps()
  end
end
