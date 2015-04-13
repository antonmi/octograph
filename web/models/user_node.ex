defmodule Octograph.UserNode do
	use Ecto.Model

	schema "user_nodes" do
    field :login, :string
    field :github_id, :integer
  end

	def new(data) do
		%__MODULE__{login: data["login"], github_id: data["id"]}
	end

	
end