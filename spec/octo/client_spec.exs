defmodule Octo.ClientSpec do

	use ESpec

	alias Octograph.Octo.Client
	

	describe "me" do
		let! :me, do: Client.me

		it "check me" do
			me |> should be_map
		 	me["email"] |> should eq "anton.mishchuk@gmail.com"
		end
	end

	describe "users" do
		let! :users, do: Client.users

		it do: expect(users).to have_count(100)

		let! :users, do: Client.users(1000)
		let! :first, do: List.first(users)

		it "check users" do
			expect(users).to have_count(100)
			expect(first["id"]).to eq(1001)
		end

		let! :antonmi, do: Client.users("antonmi")

		it do
			IO.inspect antonmi
		  antonmi["email"] |> should eq "anton.mishchuk@gmail.com"
		end 
	end

	describe "followers" do

		it do
			IO.inspect followers = Client.followers_of("alco")
			IO.inspect Enum.count(followers)
		end

		it do
			IO.inspect following = Client.following("alco")
			IO.inspect Enum.count(following)
		end

	end

end