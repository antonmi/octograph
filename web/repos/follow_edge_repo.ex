defmodule Octograph.FollowEdgeRepo do
	use Octograph.BaseRepo

	def to_nodes(user_nodes) do
		to_ids = Enum.map(user_nodes, &(&1.id))
		query = from f in Octograph.FollowEdge, where: f.to in ^to_ids, select: f
    Octograph.Repo.all(query)
	end

	def from_nodes(user_nodes) do
		to_ids = Enum.map(user_nodes, &(&1.id))
		query = from f in Octograph.FollowEdge, where: f.from in ^to_ids, select: f
    Octograph.Repo.all(query)
	end

end