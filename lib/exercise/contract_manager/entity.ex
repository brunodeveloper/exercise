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
end
