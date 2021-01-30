defmodule Exercise.ContractManager.Contract do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "contracts" do
    field :file_path, :string
    field :name, :string
    field :description, :string

    timestamps()
  end


end
