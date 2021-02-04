defmodule ExerciseWeb.Graphql.Resolvers.ContractManagerResolver do
  @moduledoc """
    The Contract resolver module.
  """

  alias Exercise.ContractManager

  def list_legal_persons(_, _) do
    {:ok, ContractManager.list_legal_persons()}
  end

  def list_legal_entities(_, _) do
    {:ok, ContractManager.list_legal_entities()}
  end

  def list_contracts(_, params, _) do
    entity_id = Map.get(params, :entity_id, nil)
    date = Map.get(params, :date, nil)

    {:ok, ContractManager.list_contracts(entity_id, date)}
  end

  def legal_persons_by_contract(contract, _, _) do
    {:ok, ContractManager.legal_persons_by_contract(contract)}
  end

  def legal_entities_by_contract(contract, _, _) do
    {:ok, ContractManager.legal_entities_by_contract(contract)}
  end

  def create_legal_person(_, params, _) do
    {:ok, ContractManager.create_legal_person(params.input)}
  end

  def create_legal_entity(_, params, _) do
    {:ok, ContractManager.create_legal_entity(params.input)}
  end

  def create_contract(_, params, _) do
    {:ok, ContractManager.create_contract(params.input)}
  end
end
