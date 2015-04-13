defmodule FollowEdgeRepoSpec do

	use ESpec

	before do
		Octograph.UserNodeRepo.delete_all
		Octograph.FollowEdgeRepo.delete_all
	end

	before do
		u1 = %Octograph.UserNode{login: "u1", github_id: 1}
		u2 = %Octograph.UserNode{login: "u2", github_id: 2}
		u3 = %Octograph.UserNode{login: "u3", github_id: 3}
		[u1, u2, u3] = Octograph.UserNodeRepo.create([u1, u2, u3])
		{:ok, u1: u1, u2: u2, u3: u3}
	end

	before do
	 	edge1 = Octograph.FollowEdge.new(__.u1.id, __.u2.id)
	 	|> Octograph.FollowEdgeRepo.create
	 	edge2 = Octograph.FollowEdge.new(__.u1.id, __.u3.id)
	 	|> Octograph.FollowEdgeRepo.create
	 	edge3 = Octograph.FollowEdge.new(__.u2.id, __.u1.id)
	 	|> Octograph.FollowEdgeRepo.create
	 	{:ok, edge1: edge1, edge2: edge2, edge3: edge3}
	end

	it do: Octograph.UserNodeRepo.count |> should eq 3
	it do: Octograph.FollowEdgeRepo.count |> should eq 3

	describe "edges" do
		let :from, do: Octograph.FollowEdgeRepo.from_nodes([__.u1])
		let :to, do: Octograph.FollowEdgeRepo.to_nodes([__.u1])

		it do
			expect(from).to have_count 2
			expect(to).to have_count 1
		end
	end

	

end