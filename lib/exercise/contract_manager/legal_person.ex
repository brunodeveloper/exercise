defmodule Exercise.ContractManager.LegalPerson do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias Exercise.ContractManager.LegalPerson

  defstruct id: nil,
            name: nil,
            cpf: nil,
            birthdate: nil

  def from_entity(entity) do
    %LegalPerson{
      id: entity.id,
      name: entity.name,
      cpf: entity.identification_document,
      birthdate: entity.birthdate
    }
  end
end
