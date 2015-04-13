defmodule Octograph.Repo.Migrations.AddGithubIdToUserNodes do
  use Ecto.Migration

  def change do
  	alter table(:user_nodes) do
  		add :github_id, :integer, null: false
		end

		create index(:user_nodes, [:github_id], unique: true)
  end
end
