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

	describe "repos" do

		it do
			followers = Client.followers_of("sasa1977")
			followers
			|> Enum.each fn(foll) ->
				IO.inspect foll["login"]
				IO.inspect Client.followers_of(foll["login"]) |> Enum.to_list |> Enum.map(&(&1["login"]))
			end
		end

	end

end