defmodule Exercise.Repo.Migrations.CreateEntities do
  use Ecto.Migration

  def change do
    create table(:entities) do
      add :name, :string, null: false
      add :identification_document, :string, null: false
      add :type_entity, :string, null: false
      add :birthdate, :date
      add :country, :string
      add :state, :string
      add :city, :string
      add :zip_code, :string
      add :address, :string

      timestamps()
    end
  end
end
