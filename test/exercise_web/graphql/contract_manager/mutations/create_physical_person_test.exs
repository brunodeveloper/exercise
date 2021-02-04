defmodule ExerciseWeb.Graphql.ContractManager.Mutations.CreatePhysicalPersonTest do
  use ExerciseWeb.ConnCase

  alias Exercise.ContractManager.Entity
  alias Exercise.Repo

  @mutation """
  mutation createPhysicalPerson($input: PhysicalPersonInput){
    createPhysicalPerson(input: $input) {
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
              name_2: "Teste 1",
              cpf: "987654321",
              birthdate: "2020-10-10"
            }
          }
        )
        |> json_response(200)

      assert response == %{
               "errors" => [
                 %{
                   "locations" => [%{"column" => 24, "line" => 2}],
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
              name: "Teste 1",
              cpf: "987654321",
              birthdate: "2020-10-10"
            }
          }
        )
        |> json_response(200)

      physical_person = Repo.get_by(Entity, %{identification_document: "987654321"})
      assert response == %{"data" => %{"createPhysicalPerson" => %{"id" => physical_person.id}}}
    end
  end
end
