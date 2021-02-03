defmodule ExerciseWeb.Graphql.ContractManagerTypes do
  @moduledoc false

  use Absinthe.Schema.Notation

  alias ExerciseWeb.Graphql.Resolvers.ContractManagerResolver

  object :contract do

    field(:id, :integer)
    field(:file_path, :string)
    field(:name, :string)
    field(:description, :string)
    field(:date, :string)

    field :legal_persons, list_of(:legal_person) do
      async(fn ->
        resolve(&ContractManagerResolver.legal_persons_by_contract/3)
      end)
    end

    field :legal_entities, list_of(:legal_entity) do
      async(fn ->
        resolve(&ContractManagerResolver.legal_entities_by_contract/3)
      end)
    end
  end

  object :legal_person do
    field(:id, :integer)
    field(:name, :string)
    field(:cpf, :string)
    field(:birthdate, :string)
  end

  object :legal_entity do
    field(:id, :integer)
    field(:name, :string)
    field(:cnpj, :string)
    field(:country, :string)
    field(:state, :string)
    field(:city, :string)
    field(:zip_code, :string)
    field(:address, :string)
  end

  object :legal_person_payload do
    field(:id, :integer)
  end

  input_object :legal_person_input do
    field(:name, non_null(:string))
    field(:cpf, non_null(:string))
    field(:birthdate, non_null(:string))
  end

  object :legal_entity_payload do
    field(:id, :integer)
  end

  input_object :legal_entity_input do
    field(:name, non_null(:string))
    field(:cnpj, non_null(:string))
    field(:country, non_null(:string))
    field(:state, non_null(:string))
    field(:city, non_null(:string))
    field(:zip_code, non_null(:string))
    field(:address, non_null(:string))
  end

  object :contract_payload do
    field(:id, :integer)
  end

  input_object :contract_input do
    field(:file_path, non_null(:string))
    field(:name, non_null(:string))
    field(:description, non_null(:string))
    field(:date, non_null(:string))
    field(:entities, list_of(:integer))
  end


end
