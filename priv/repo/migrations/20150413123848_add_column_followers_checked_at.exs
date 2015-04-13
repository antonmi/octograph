defmodule Octograph.Repo.Migrations.AddColumnFollowersCheckedAt do
  use Ecto.Migration

  def change do
  	alter table(:user_nodes) do
  		add :followers_checked_at, :datetime
		end
  end
end
