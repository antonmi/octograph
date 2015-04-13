defmodule UserNodeRepoSpec do

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

	describe "find_by_ids" do
		subject Octograph.UserNodeRepo.find_by_ids([__.u1.id, __.u2.id, __.u3.id])

		it do: should have_count 3
	end 

	describe "last" do
		let :last, do: Octograph.UserNodeRepo.last
		it do: last.login |> should eq "u3"
	end

	describe "last_by_github_id" do
		let :last, do: Octograph.UserNodeRepo.last_by_github_id
		it do: last.github_id |> should eq 3
	end
end