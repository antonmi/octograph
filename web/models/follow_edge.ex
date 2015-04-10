defmodule Octograph.FollowEdge do
	use Ecto.Model
	
	schema "follow_edges" do
    field :from, :integer
    field :to, :integer
  end

	def new(from, to) do
		%__MODULE__{from: from, to: to}
	end
end