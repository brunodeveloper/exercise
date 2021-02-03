defmodule ExerciseWeb.Graphql.ContractManagerMutations do
  @moduledoc false

  use Absinthe.Schema.Notation

  alias ExerciseWeb.Graphql.Resolvers.ContractManagerResolver

  object :contract_mutations do
    field :create_legal_person, :legal_person_payload do
      arg(:input, non_null(:legal_person_input))
      resolve(&ContractManagerResolver.create_legal_person/3)
    end

    field :create_legal_entity, :legal_entity_payload do
      arg(:input, non_null(:legal_entity_input))
      resolve(&ContractManagerResolver.create_legal_entity/3)
    end

    field :create_contract, :contract_payload do
      arg(:input, non_null(:contract_input))
      resolve(&ContractManagerResolver.create_contract/3)
    end

  end

end
