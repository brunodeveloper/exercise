defmodule ExerciseWeb.Graphql.ContractManager.Queries.ListLegalEntityTest do
  use ExerciseWeb.ConnCase

  alias Exercise.ContractManager.Entity
  alias Exercise.Repo

  @query """
  query{
    listLegalEntities {
      id
      name
      cnpj
      country
      state
      city
      address
      zipCode
    }
  }
  """

  describe "when there is no registration of legal entities" do
    test "returns a empty list", %{conn: conn} do
      response =
        conn
        |> post("/graphql", query: @query)
        |> json_response(200)

      list_legal_entities = Repo.get_by(Entity, type_entity: Entity.entity_type_legal_entity())

      assert response === %{"data" => %{"listLegalEntities" => []}}
      assert list_legal_entities === nil
    end
  end

  describe "when there is registration of legal entities" do
    test "returns a list with legal entities", %{conn: conn} do
      legal_entity =
        %Entity{
          name: "Fulano",
          identification_document: "987654321/0001",
          country: "BR",
          state: "SP",
          city: "SAO PAULO",
          address: "RUA TESTE",
          zip_code: "01010-010",
          type_entity: Entity.entity_type_legal_entity()
        }
        |> Repo.insert!()

      response =
        conn
        |> post("/graphql", query: @query)
        |> json_response(200)

      assert response === %{
               "data" => %{
                 "listLegalEntities" => [
                   %{
                     "id" => legal_entity.id,
                     "name" => legal_entity.name,
                     "cnpj" => legal_entity.identification_document,
                     "country" => legal_entity.country,
                     "state" => legal_entity.state,
                     "city" => legal_entity.city,
                     "address" => legal_entity.address,
                     "zipCode" => legal_entity.zip_code
                   }
                 ]
               }
             }
    end
  end
end
