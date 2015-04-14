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

	describe "update_or_create" do
		before do
			data = %{"login" => "test", "id" => 100500}
			user_node = Octograph.UserNode.new(data)
			{:ok, user_node: user_node}
		end

		before do
			created = Octograph.UserNodeRepo.update_or_create(__.user_node)
			{:ok, created: created}
		end

		let :user_node, do: Octograph.UserNodeRepo.find_by_login("test")

		it "check user_node" do
			expect(user_node.login).to eq("test")
			expect(user_node.github_id).to eq(100500)
		end

		context "udpdate" do
			before do
				data = %{"login" => "test", "id" => 100501}
				user_node = Octograph.UserNode.new(data)
				Octograph.UserNodeRepo.update_or_create(user_node)
			end
			
			let :user_node, do: Octograph.UserNodeRepo.find_by_login("test")
			
			it "check user_node" do
				expect(user_node.login).to eq("test")
				expect(user_node.github_id).to eq(100501)
			end
		end


	end

	describe "followers_updated" do
		before do
			Octograph.UserNode.followers_updated!(__.u1)
		end

		let :u1, do: Octograph.UserNodeRepo.find_by_login("u1")

		it "check datetime" do
		 	expect(u1.followers_checked_at.day).to be :>, 0
		end
	end


	describe "without_followers" do
		before do
			Octograph.UserNode.followers_updated!(__.u1)
		end

		let :users, do: Octograph.UserNodeRepo.without_followers
		it do: Enum.map(users, &(&1.login)) |> should eq ["u2", "u3"]
	end
end