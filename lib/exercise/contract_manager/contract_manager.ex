defmodule Exercise.ContractManager do
  @moduledoc """
  Module responsible for the contract manager actions.
  """
  import Ecto.Query
  alias Exercise.Repo
  alias Exercise.ContractManager.Contract
  alias Exercise.ContractManager.ContractEntity
  alias Exercise.ContractManager.Entity
  alias Exercise.ContractManager.LegalPerson
  alias Exercise.ContractManager.LegalEntity

  def list_legal_persons do
    from(
      e in Entity,
      where: e.type_entity == ^Entity.entity_type_legal_person(),
      select: e
    )
    |> Repo.all()
    |> Enum.map(&LegalPerson.from_entity(&1))
  end

  def list_legal_entities do
    from(
      e in Entity,
      where: e.type_entity == ^Entity.entity_type_legal_entity(),
      select: e
    )
    |> Repo.all()
    |> Enum.map(&LegalEntity.from_entity(&1))
  end

  def list_contracts(entity, date) do
    from(
      c in Contract,
      select: c
    )
    |> filter_date(date)
    |> filter_entity(entity)
    |> Repo.all()
  end

  defp filter_date(queryable, date) when is_nil(date), do: queryable

  defp filter_date(queryable, date) do
    queryable
    |> where([c], c.date == ^date)
  end

  defp filter_entity(queryable, entity) when is_nil(entity), do: queryable

  defp filter_entity(queryable, entity) do
    queryable
    |> join(:inner, [c], ce in ContractEntity,
      on: c.id == ce.contract_id and ce.entity_id == ^entity
    )
    |> group_by([c], c.id)
  end

  def legal_persons_by_contract(contract) do
    from(
      ce in ContractEntity,
      where: ce.contract_id == ^contract.id,
      join: e in Entity,
      on: ce.entity_id == e.id and e.type_entity == ^Entity.entity_type_legal_person(),
      select: e
    )
    |> Repo.all()
    |> Enum.map(&LegalPerson.from_entity(&1))
  end

  def legal_entities_by_contract(contract) do
    from(
      ce in ContractEntity,
      where: ce.contract_id == ^contract.id,
      join: e in Entity,
      on: ce.entity_id == e.id and e.type_entity == ^Entity.entity_type_legal_entity(),
      select: e
    )
    |> Repo.all()
    |> Enum.map(&LegalEntity.from_entity(&1))
  end
end
