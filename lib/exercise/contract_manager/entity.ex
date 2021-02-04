defmodule Exercise.ContractManager.Entity do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "entities" do
    field :name, :string
    field :type_entity, :string
    field :identification_document, :string
    field :birthdate, :date
    field :country, :string
    field :state, :string
    field :city, :string
    field :zip_code, :string
    field :address, :string

    timestamps()
  end

  def entity_type_legal_entity(), do: "legal_entity"

  def entity_type_legal_person(), do: "legal_person"

  def create_legal_person_changeset(entity, attrs) do
    entity
    |> cast(attrs, [:name, :identification_document, :birthdate, :type_entity])
  end

  def create_legal_entity_changeset(entity, attrs) do
    entity
    |> cast(attrs, [
      :name,
      :identification_document,
      :country,
      :state,
      :city,
      :zip_code,
      :address,
      :type_entity
    ])
  end
end
