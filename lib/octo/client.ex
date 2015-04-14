defmodule Octograph.Octo.Client do

	alias Tentacat.Users
	alias Tentacat.Users.Followers
	alias Tentacat.Repositories

	def me, do: Users.me(client)

	def users, do: Users.list(client)
	def users(since) when is_integer(since), do: Users.list_since(since, client)
	def users(name) when is_binary(name), do: Users.find(name, client)

	def repos_of(name) do
		Repositories.list_users(name, client)
	end

	def followers_of(name) do
		Tentacat.Users.Followers.followers(name, client)
	end

	def following(name) do
		Tentacat.Users.Followers.following(name, client)
	end

	def client, do:	%Tentacat.Client{auth: %{access_token: access_token}}

	defp access_token, do: Application.get_env(:octograph, :github_token)


	def connections(name) do
		user_data = users(name)
		user_node = Octograph.UserNode.new(user_data)
		user = Octograph.UserNodeRepo.update_or_create(user_node)
		
		followers = Octograph.Octo.Client.followers_of(name)
		Enum.each(followers, fn(foll) -> 
			user_node = Octograph.UserNode.new(foll)
			u = Octograph.UserNodeRepo.update_or_create(user_node)
			edge = Octograph.FollowEdge.new(user.id, u.id)
			Octograph.FollowEdgeRepo.create(edge)	
		end)

		following = Octograph.Octo.Client.following(name)
		Enum.each(following, fn(foll) -> 
			user_node = Octograph.UserNode.new(foll)
			u = Octograph.UserNodeRepo.find_or_create_by(user_node)
			edge = Octograph.FollowEdge.new(u.id, user.id)
			Octograph.FollowEdgeRepo.create(edge)	
		end)
	end
end

