defmodule Exercise.ContractManager.PhysicalPerson do
  @moduledoc false

  use Ecto.Schema

  alias Exercise.ContractManager.PhysicalPerson

  defstruct id: nil,
            name: nil,
            cpf: nil,
            birthdate: nil

  def from_entity(entity) do
    %PhysicalPerson{
      id: entity.id,
      name: entity.name,
      cpf: entity.identification_document,
      birthdate: entity.birthdate
    }
  end
end
