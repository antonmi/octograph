defmodule Octograph.Repo.Migrations.CreateUserNodes do
  use Ecto.Migration

  def change do
  	create table :user_nodes do
      add :login, :string, null: false
    end

    create index(:user_nodes, [:login], unique: true)
  end
end
