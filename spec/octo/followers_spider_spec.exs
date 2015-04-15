defmodule FollowersSpiderSpec do

	use ESpec

	before do
		Octograph.UserNodeRepo.delete_all
		Octograph.FollowEdgeRepo.delete_all
	end

	before do
		data = %{"login" => "brianleroux", "id" => 990}
		user = Octograph.UserNode.new(data)
		user = Octograph.UserNodeRepo.create(user)
		{:ok, user: user}
	end

	describe "update_user_data" do
		let :data, do: Octograph.Octo.Client.users("brianleroux")

		before do
			Octograph.Octo.FollowersSpider.update_user_data(__.user)
		end

		let :user, do: Octograph.UserNodeRepo.find_by_login("brianleroux")
		
		it "check flrs_count and flng_count" do
			user.flng_count |> should eq data["following"]
			user.flrs_count |> should eq data["followers"]
		end

		describe "find_followers" do
			before do
				Octograph.Octo.FollowersSpider.find_followers(user)
			end	

			it "checks records" do
				expect(Octograph.FollowEdgeRepo.count).to eq(user.flrs_count)
				expect(Octograph.FollowEdgeRepo.from_nodes([user]) |> Enum.count).to eq(user.flrs_count)

				expect(Octograph.UserNodeRepo.count).to eq(user.flrs_count + 1)
			end

			context "again" do
				before do: Octograph.Octo.FollowersSpider.find_followers(user)
				it "checks records" do
					expect(Octograph.FollowEdgeRepo.count).to eq(user.flrs_count)
					expect(Octograph.FollowEdgeRepo.from_nodes([user]) |> Enum.count).to eq(user.flrs_count)

					expect(Octograph.UserNodeRepo.count).to eq(user.flrs_count + 1)
				end
			end
		end

	end

	describe "Start" do
	 	before do
	 	  Octograph.Octo.FollowersSpider.start
	 	  Octograph.Octo.FollowersSpider.stop
	 	end 
		
		let :user, do: Octograph.UserNodeRepo.find_by_login("brianleroux")
	 	
	 	it "checks" do
	 		expect(Octograph.FollowEdgeRepo.count).to eq(user.flrs_count)
	 		expect(user.followers_checked_at.day).to be :>, 0
	 	end
	end





end