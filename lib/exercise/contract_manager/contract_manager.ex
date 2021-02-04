defmodule Exercise.ContractManager do
  @moduledoc """
  Module responsible for the contract manager actions.
  """
  import Ecto.Query
  alias Exercise.Repo
  alias Exercise.ContractManager.Contract
  alias Exercise.ContractManager.ContractEntity
  alias Exercise.ContractManager.Entity
  alias Exercise.ContractManager.PhysicalPerson
  alias Exercise.ContractManager.LegalEntity

  def list_physical_persons do
    from(
      e in Entity,
      where: e.type_entity == ^Entity.entity_type_physical_person(),
      select: e
    )
    |> Repo.all()
    |> Enum.map(&PhysicalPerson.from_entity(&1))
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

  def physical_persons_by_contract(contract) do
    from(
      ce in ContractEntity,
      where: ce.contract_id == ^contract.id,
      join: e in Entity,
      on: ce.entity_id == e.id and e.type_entity == ^Entity.entity_type_physical_person(),
      select: e
    )
    |> Repo.all()
    |> Enum.map(&PhysicalPerson.from_entity(&1))
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

  def create_physical_person(new_physical_person) do
    physical_person = %{
      name: new_physical_person.name,
      identification_document: new_physical_person.cpf,
      birthdate: new_physical_person.birthdate,
      type_entity: Entity.entity_type_physical_person()
    }

    %Entity{}
    |> Entity.create_physical_person_changeset(physical_person)
    |> Repo.insert!()
  end

  def create_legal_entity(new_legal_entity) do
    legal_entity = %{
      name: new_legal_entity.name,
      identification_document: new_legal_entity.cnpj,
      country: new_legal_entity.country,
      state: new_legal_entity.state,
      city: new_legal_entity.city,
      zip_code: new_legal_entity.zip_code,
      address: new_legal_entity.address,
      type_entity: Entity.entity_type_legal_entity()
    }

    %Entity{}
    |> Entity.create_legal_entity_changeset(legal_entity)
    |> Repo.insert!()
  end

  def insert_contract(new_contract) do
    contract = %{
      file_path: new_contract.file_path,
      name: new_contract.name,
      description: new_contract.description,
      date: new_contract.date
    }

    %Contract{}
    |> Contract.create_changeset(contract)
    |> Repo.insert()
  end

  def insert_contract_entities(contract_id, entity_id) do
    try do
      contract = %{
        contract_id: contract_id,
        entity_id: entity_id
      }

      %ContractEntity{}
      |> ContractEntity.create_changeset(contract)
      |> Repo.insert()
    rescue
      _ -> false
    end
  end

  def create_contract(contract) do
    case insert_contract(contract) do
      {:ok, new_contract} ->
        _insert =
          contract.entities
          |> Enum.map(fn entity ->
            insert_contract_entities(new_contract.id, entity)
          end)

        new_contract

      _ ->
        false
    end
  end
end
