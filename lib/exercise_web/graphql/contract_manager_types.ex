defmodule ExerciseWeb.Graphql.ContractManagerTypes do
  @moduledoc false

  use Absinthe.Schema.Notation

  object :contract do
    field(:id, :integer)
    field(:file_path, :string)
    field(:name, :string)
    field(:description, :string)
    field(:date, :string)
  end

  object :address do
    field(:address, :string)
    field(:number, :string)
    field(:city, :string)
    field(:state, :string)
    field(:country, :string)
    field(:zipcode, :string)
  end

end
