defmodule Octograph.Repo.Migrations.AddFlrsCountAndFlngCount do
  use Ecto.Migration

  def change do
  	alter table(:user_nodes) do
  		add :flrs_count, :integer
  		add :flng_count, :integer
		end
  end
end
