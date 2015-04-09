defmodule OctoUserRepoSpec do

	use ESpec
	alias Octograph.OctoUserRepo

	before do 
		Mongo.Collection.drop(Octograph.OctoUserRepo.collection)
	end

	describe "create user" do
		before do
	 		antonmi = Octograph.Octo.Client.users("antonmi")
 			user = Octograph.OctoUser.build(antonmi)
 			OctoUserRepo.create(user)
			{:ok, antonmi: antonmi}
		end

		let! :user, do: OctoUserRepo.find_by_id("github_#{__.antonmi["id"]}")
		
		it do
			user._id |> should eq "github_#{__.antonmi["id"]}"
			data = Poison.decode(user.data)
			{:ok, d} = Poison.encode(__.antonmi)
			expect(data).to eq Poison.decode(d)
		end
	end

	describe "all" do
		before do
			OctoUserRepo.create([
				%Octograph.OctoUser{_id: "id1", data: "www"},
				%Octograph.OctoUser{_id: "id2", data: "www"}
				])
			:ok
		end

		it do 
			OctoUserRepo.all |> should have_count 2
		end

		it do 
			OctoUserRepo.count |> should eq 2
		end
	end

	describe "last" do
		before do
			OctoUserRepo.create([
				%Octograph.OctoUser{_id: "id3", data: "e"},
				%Octograph.OctoUser{_id: "id1", data: "q"},
				%Octograph.OctoUser{_id: "id2", data: "w"}
				])
			:ok
		end

		let :last, do: Octorgraph.OctoUserRepo.last
		
		it do: OctoUserRepo.count |> should eq 3
		it do 
			last.data |> should eq "e" 
		end

	end

	describe "with client" do
		before do
			users = Octograph.Octo.Client.users(0)
			users = users |> Enum.map(&(Octograph.OctoUser.build(&1)))
			chunks = Enum.chunk(users, 30)
			
			OctoUserRepo.create(List.first(chunks))
			OctoUserRepo.create(List.last(chunks))

			{:ok, users: users}
		end

		it do
			# IO.inspect Enum.count(__.users)
			# IO.inspect Octograph.OctoUserRepo.ids
			IO.inspect List.last(__.users)._id
			# IO.inspect List.last(Octograph.OctoUserRepo.ids)
			# IO.inspect List.last(__.users).id
		  # OctoUserRepo.last.github_id |> should eq List.last(__.users)["id"]
		end 
	end

end
