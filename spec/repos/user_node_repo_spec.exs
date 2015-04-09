defmodule UserNodeRepoSpec do

	use ESpec
	alias Octograph.UserNodeRepo
	alias Octograph.FollowEdgeRepo
	alias Octograph.FollowEdge
	alias Octograph.UserNode
	alias Octograph.Octo.Client 

	before do
		["node_1", "node_2", "node_3"]
		|> Enum.each fn(id) ->
			un = %UserNode{id: id}
			UserNodeRepo.create(un)
		end
	end

	it do
		IO.inspect UserNodeRepo.all

	end

	context "use client"  do

	it do
		Octograph.Octo.Client.connections("antonmi")
		Octograph.UserNodeRepo.all |> Enum.each(fn(u) -> Octograph.Octo.Client.connections(u.id) end)

		IO.inspect Octograph.FollowEdgeRepo.all
	end

	end
end