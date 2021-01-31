defmodule Exercise.ContractManager.LegalEntity do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias Exercise.ContractManager.LegalEntity

  defstruct id: nil,
            name: nil,
            cnpj: nil,
            country: nil,
            state: nil,
            city: nil,
            zip_code: nil,
            address: nil

  def from_entity(entity) do
    %LegalEntity{
      id: entity.id,
      name: entity.name,
      cnpj: entity.identification_document,
      country: entity.country,
      state: entity.state,
      city: entity.city,
      zip_code: entity.zip_code,
      address: entity.address
    }
  end
end
