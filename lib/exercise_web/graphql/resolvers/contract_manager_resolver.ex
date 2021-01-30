defmodule ExerciseWeb.Graphql.Resolvers.ContractManagerResolver do
  @moduledoc """
    The Contract resolver module.
  """

  def contracts(_, _) do
    {:ok, "List contracts"}
  end
end
