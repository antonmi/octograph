defmodule Octograph.UserNode do
	use Ecto.Model

	schema "user_nodes" do
    field :login, :string
  end

	def new(data) do
		%__MODULE__{login: data["login"]}
	end

	
end