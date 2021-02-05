defmodule ExerciseWeb.Graphql.ContractManager.Queries.ListContractsTest do
  use ExerciseWeb.ConnCase

  alias Exercise.ContractManager.Contract
  alias Exercise.Repo

  @query """
  query ($date: String, $entityId: Int) {
    listContracts (date: $date, entityId: $entityId){
    id
    name
    date
    description
    filePath
    legalEntities {
        id
        address
        city
        cnpj
        country
        state
        zipCode
      }
      physicalPersons{
        id
        name
        cpf
        birthdate
      }
    }
  }
  """

  describe "when there is no registration of contracts" do
    test "returns a empty list", %{conn: conn} do
      response =
        conn
        |> post("/graphql", query: @query)
        |> json_response(200)

      list_contracts = Repo.all(Contract)

      assert response === %{"data" => %{"listContracts" => []}}
      assert list_contracts === []
    end
  end
end
