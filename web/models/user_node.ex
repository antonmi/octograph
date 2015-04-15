defmodule Octograph.UserNode do
	use Ecto.Model

	schema "user_nodes" do
    field :login, :string
    field :github_id, :integer
    field :flrs_count, :integer
  	field :flng_count, :integer
    field :followers_checked_at, Ecto.DateTime
  end

	def new(data) do
		%__MODULE__{
			login: data["login"],
			github_id: data["id"]
		}
	end

	def followers_updated!(user_node) do
		user_node = %__MODULE__{user_node | followers_checked_at: Ecto.DateTime.utc}
		Octograph.Repo.update(user_node)
	end

	
end