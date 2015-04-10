defmodule Octograph.Traverser do
	

	def level(n) do
		acc0 = {[Octograph.UserNodeRepo.find_by_login("ievgenp")], []}
		acc0 = {[Octograph.UserNodeRepo.sample], []}
		Enum.reduce((1..n), acc0, fn(_i, acc) -> 
			{nodes, edges} = acc
			new_edges = Octograph.FollowEdgeRepo.to_nodes(nodes)
			ids = Enum.map(new_edges, &(&1.from))
			new_nodes = Octograph.UserNodeRepo.find_by_ids(ids)

			{nodes ++ new_nodes, edges ++ new_edges}
		end)
	end
		
end