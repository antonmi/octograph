defmodule Octograph.OctoUserRepo do

	use Octograph.BaseRepo

	@collection "octo_users"

	def create(octo_users) when is_list(octo_users) do
		octo_users
		|> Enum.map(fn(u) -> 
			Map.delete(u, :__struct__)
		end) 
		|> Mongo.Collection.insert(collection)
	end

	def create(octo_user), do: create([octo_user])

	def find_by_id(id) do
		data = Mongo.Collection.find(collection, "obj._id == \"#{id}\"")
		|> Enum.to_list |> List.first
		if data, do: Map.put(data, :__struct__, Octograph.OctoUser)
	end

	def all do
		Mongo.Collection.find(collection)
		|> Enum.to_list
	end

	def last do
		Mongo.Collection.aggregate(collection, [%{'$sort': %{'_id': -1}}, %{'$limit': 1}])
		|> Enum.to_list |> List.first
	end

	def ids do
		Mongo.Collection.group(collection, %{_id: true})
	end


	def count do
		{:ok, count} = Mongo.Collection.count(collection)
		count
	end	

	def ids do
		Mongo.Collection.group!(collection, %{_id: true})
	end


	def collection, do: db |> Mongo.Db.collection(@collection)
end