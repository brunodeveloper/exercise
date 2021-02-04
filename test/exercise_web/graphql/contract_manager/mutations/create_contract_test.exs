defmodule ExerciseWeb.Graphql.ContractManager.Mutations.CreateContractTest do
  use ExerciseWeb.ConnCase

  alias Exercise.ContractManager.Contract
  alias Exercise.ContractManager.ContractEntity
  alias Exercise.ContractManager.Entity
  alias Exercise.Repo

  @mutation """
  mutation createContract($input: ContractInput){
    createContract(input: $input) {
      id
    }
  }
  """

  describe "an invalid payload" do
    test "returns errors has invalid value", %{conn: conn} do
      response =
        conn
        |> post("/graphql",
          query: @mutation,
          variables: %{
            input: %{
              date_2: "2021-01-01",
              description: "Descricao do contrato",
              name: "Nome do contrato",
              filePath: "arquivo_do_contrato.pdf",
              entities: [0]
            }
          }
        )
        |> json_response(200)

      assert response == %{
               "errors" => [
                 %{
                   "locations" => [%{"column" => 18, "line" => 2}],
                   "message" =>
                     "Argument \"input\" has invalid value $input.\nIn field \"date\": Expected type \"String!\", found null.\nIn field \"date_2\": Unknown field. Did you mean \"date\"?"
                 }
               ]
             }
    end
  end

  describe "a valid payload and an entity that does not exist" do
    test "returns the entity ID that was successfully created", %{conn: conn} do
      response =
        conn
        |> post("/graphql",
          query: @mutation,
          variables: %{
            input: %{
              date: "2021-01-01",
              description: "Descricao do contrato",
              name: "Nome do contrato",
              filePath: "arquivo_do_contrato.pdf",
              entities: [1]
            }
          }
        )
        |> json_response(200)

      list_contract_entities = Repo.all(ContractEntity)

      contract = Repo.get_by(Contract, %{name: "Nome do contrato"})
      assert response == %{"data" => %{"createContract" => %{"id" => contract.id}}}
      assert list_contract_entities == []
    end
  end

  describe "a valid payload and an entity valid" do
    test "returns the entity ID that was successfully created", %{conn: conn} do
      entity =
        Repo.insert!(%Entity{
          name: "Nome da entidade",
          identification_document: "98765432100",
          birthdate: "1980-10-10" |> Date.from_iso8601!()
        })

      response =
        conn
        |> post("/graphql",
          query: @mutation,
          variables: %{
            input: %{
              date: "2021-01-01",
              description: "Descricao do contrato",
              name: "Nome do contrato",
              filePath: "arquivo_do_contrato.pdf",
              entities: [entity.id]
            }
          }
        )
        |> json_response(200)

      list_contract_entities = Repo.all(ContractEntity)

      contract = Repo.get_by(Contract, %{name: "Nome do contrato"})
      assert response == %{"data" => %{"createContract" => %{"id" => contract.id}}}
      assert list_contract_entities !== []
    end
  end
end
