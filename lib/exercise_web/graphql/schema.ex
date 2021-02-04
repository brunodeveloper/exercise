defmodule ExerciseWeb.Graphql.Schema do
  @moduledoc false
  use Absinthe.Schema

  import_types(ExerciseWeb.Graphql.ContractManagerTypes)
  import_types(ExerciseWeb.Graphql.ContractManagerQueries)
  import_types(ExerciseWeb.Graphql.ContractManagerMutations)

  query do
    import_fields(:contract_queries)
  end

  mutation do
    import_fields(:contract_mutations)
  end
end
