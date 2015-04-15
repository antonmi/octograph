	defmodule Octograph.Octo.FollowersSpider do

	use GenServer

	def start do
		{:ok, pid} = GenServer.start_link(__MODULE__, [], name: __MODULE__)
		GenServer.cast __MODULE__, :start
		pid
	end

	def init(args) do
		last = Octograph.UserNodeRepo.first_without_followers
		{:ok, %{last: last}}
	end

	def stop do
		GenServer.call(__MODULE__, :stop, :infinity)
	end

	def info do
		if Process.whereis(Octograph.Octo.FollowersSpider) do
			state = GenServer.call(__MODULE__, :info, :infinity)
			%{status: :active, state: state}
		else 
			%{status: :inactive, state: %{}}
		end	
	end

	def get_followers(user) do
		user = update_user_data(user)
		find_followers(user) 
		Octograph.UserNode.followers_updated!(user)
		last = Octograph.UserNodeRepo.first_without_followers
		GenServer.cast __MODULE__, {:next, %{last: last}}
	end

	def update_user_data(user) do
		data = Octograph.Octo.Client.users(user.login)
		user = %{user | flng_count: data["following"], flrs_count: data["followers"]}
		Octograph.UserNodeRepo.update(user)
	end

	def find_followers(user) do
		data = Octograph.Octo.Client.all_followers(user)
		followers = Octograph.UserNodeRepo.find_or_create_followers(data)
		Enum.each(followers, fn(fol) ->
			edge = Octograph.FollowEdge.new(user.id, fol.id)
			Octograph.FollowEdgeRepo.create(edge)
		end)
	end

	def handle_cast(:start, state) do
		get_followers(state.last)
		{:noreply, state}
	end

	def handle_cast({:next, new_state}, _state) do
		get_followers(new_state.last)
		{:noreply, new_state}
	end

	def handle_call(:stop, _pid, state) do
		{:stop, :normal, :ok, state}
	end

	def handle_call(:info, _pid, state) do
		{:reply, state, state}
	end
end