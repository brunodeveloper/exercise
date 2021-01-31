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

  def list_contracts(_, _) do
    {:ok, ContractManager.list_contracts()}
  end

  def legal_persons_by_contract(contract, _, _) do
    {:ok, ContractManager.legal_persons_by_contract(contract)}
  end

  def legal_entities_by_contract(contract, _, _) do
    {:ok, ContractManager.legal_entities_by_contract(contract)}
  end
end
