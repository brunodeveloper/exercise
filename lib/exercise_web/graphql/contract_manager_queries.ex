defmodule ExerciseWeb.Graphql.ContractManagerQueries do
  @moduledoc false

  use Absinthe.Schema.Notation

  alias ExerciseWeb.Graphql.Resolvers.ContractManagerResolver

  object :contract_queries do
    field :contracts, :string do
      resolve(&ContractManagerResolver.contracts/2)
    end
  end
end
