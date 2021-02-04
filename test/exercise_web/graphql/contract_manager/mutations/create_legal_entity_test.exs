defmodule ExerciseWeb.Graphql.ContractManager.Mutations.CreateLegalEntityTest do
  use ExerciseWeb.ConnCase

  alias Exercise.ContractManager.Entity
  alias Exercise.Repo

  @mutation """
  mutation createLegalEntity($input: LegalEntityInput){
    createLegalEntity(input: $input) {
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
              name_2: "Nome da empresa",
              cnpj: "987654321",
              country: "BR",
              city: "SAO PAULO",
              state: "SP",
              address: "RUA TESTE",
              zipCode: "01234-56"
            }
          }
        )
        |> json_response(200)

      assert response == %{
               "errors" => [
                 %{
                   "locations" => [%{"column" => 21, "line" => 2}],
                   "message" =>
                     "Argument \"input\" has invalid value $input.\nIn field \"name\": Expected type \"String!\", found null.\nIn field \"name_2\": Unknown field. Did you mean \"name\"?"
                 }
               ]
             }
    end
  end

  describe "a valid payload" do
    test "returns the entity ID that was successfully created", %{conn: conn} do
      response =
        conn
        |> post("/graphql",
          query: @mutation,
          variables: %{
            input: %{
              name: "Nome da empresa",
              cnpj: "987654321",
              country: "BR",
              city: "SAO PAULO",
              state: "SP",
              address: "RUA TESTE",
              zipCode: "01234-56"
            }
          }
        )
        |> json_response(200)

      legal_entity = Repo.get_by(Entity, %{identification_document: "987654321"})
      assert response == %{"data" => %{"createLegalEntity" => %{"id" => legal_entity.id}}}
    end
  end
end
