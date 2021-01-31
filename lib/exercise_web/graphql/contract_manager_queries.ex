defmodule ExerciseWeb.Graphql.ContractManagerQueries do
  @moduledoc false

  use Absinthe.Schema.Notation

  alias ExerciseWeb.Graphql.Resolvers.ContractManagerResolver

  object :contract_queries do
    field :list_contracts, list_of(:contract) do
      arg(:entity_id, :integer)
      arg(:date, :string)

      resolve(&ContractManagerResolver.list_contracts/3)
    end

    field :list_legal_persons, list_of(:legal_person) do
      resolve(&ContractManagerResolver.list_legal_persons/2)
    end

    field :list_legal_entities, list_of(:legal_entity) do
      resolve(&ContractManagerResolver.list_legal_entities/2)
    end
  end
end
