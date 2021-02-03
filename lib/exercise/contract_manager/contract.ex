defmodule Exercise.ContractManager.Contract do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "contracts" do
    field :file_path, :string
    field :name, :string
    field :description, :string
    field :date, :date

    timestamps()
  end

  def create_changeset(contract, attrs) do
    contract
    |> cast(attrs, [:file_path, :name, :description, :date])
  end
end
