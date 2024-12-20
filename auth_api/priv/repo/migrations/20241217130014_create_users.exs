defmodule AuthApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :firstname, :string, null: false
      add :lastname, :string, null: false
      add :email, :string, null: false
      add :username, :string, null: false
      add :unique, :string, null: true
      add :password, :string, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, [:email])
  end
end
