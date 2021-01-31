defmodule Exercise.Repo.Migrations.CreateContracts do
  use Ecto.Migration

  def change do
    create table(:contracts) do
      add :name, :string, null: false
      add :description, :string, null: false
      add :date, :date, null: false
      add :file_path, :string, null: false

      timestamps()
    end
  end
end
