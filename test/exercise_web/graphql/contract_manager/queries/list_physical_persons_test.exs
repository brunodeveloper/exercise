defmodule ExerciseWeb.Graphql.ContractManager.Queries.ListPhysicalPersonsTest do
  use ExerciseWeb.ConnCase

  alias Exercise.ContractManager.Entity
  alias Exercise.Repo

  @query """
    query{
      listPhysicalPersons {
        id
        name
        cpf
        birthdate
      }
    }
  """

  describe "when there is no registration of physical persons" do
    test "returns a empty list", %{conn: conn} do
      response =
        conn
        |> post("/graphql", query: @query)
        |> json_response(200)

      list_physical_persons =
        Repo.get_by(Entity, type_entity: Entity.entity_type_physical_person())

      assert response === %{"data" => %{"listPhysicalPersons" => []}}
      assert list_physical_persons === nil
    end
  end

  describe "when there is registration of physical persons" do
    test "returns a list with physical persons", %{conn: conn} do
      physical_person =
        %Entity{
          name: "Fulano",
          identification_document: "987654321",
          birthdate: "1980-01-01" |> Date.from_iso8601!(),
          type_entity: Entity.entity_type_physical_person()
        }
        |> Repo.insert!()

      response =
        conn
        |> post("/graphql", query: @query)
        |> json_response(200)

      assert response === %{
               "data" => %{
                 "listPhysicalPersons" => [
                   %{
                     "birthdate" => "1980-01-01",
                     "cpf" => "987654321",
                     "id" => physical_person.id,
                     "name" => "Fulano"
                   }
                 ]
               }
             }
    end
  end
end
