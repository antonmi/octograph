defmodule Octograph.Repo.Migrations.CreateFollowEdges do
  use Ecto.Migration

  def change do
  	create table :follow_edges do
      add :from, :integer, null: false
      add :to, :integer, null: false
    end

    create index(:follow_edges, [:from, :to], unique: true)
  end
end
