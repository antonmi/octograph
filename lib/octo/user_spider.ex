	defmodule Octograph.Octo.UserSpider do

	use GenServer

	def start do
		{:ok, pid} = GenServer.start_link(__MODULE__, [], name: __MODULE__)
		GenServer.cast __MODULE__, :start
		pid
	end

	def init(args) do
		last = Octograph.UserNodeRepo.last_by_github_id || %{github_id: 0}
		{:ok, %{since: last.github_id}}
	end

	def stop do
		GenServer.call(__MODULE__, :stop)
	end

	def info do
		if Process.whereis(Octograph.Octo.UserSpider) do
			state = GenServer.call(__MODULE__, :info, :infinity)
			%{status: :active, state: state}
		else 
			%{status: :inactive, state: %{}}
		end	
	end

	def get_users(since) do
		users = Octograph.Octo.Client.users(since)
		Enum.each users, fn(user) ->
			Octograph.UserNodeRepo.find_or_create_by(user["login"], user["id"])
		end
		last = List.last(users)
		GenServer.cast __MODULE__, {:next, %{since: last["id"]}}
	end

	def handle_cast(:start, state) do
		get_users(state.since)
		{:noreply, state}
	end

	def handle_cast({:next, new_state}, _state) do
		get_users(new_state.since)
		{:noreply, new_state}
	end

	def handle_call(:stop, _pid, state) do
		{:stop, :normal, :ok, state}
	end

	def handle_call(:info, _pid, state) do
		{:reply, state, state}
	end
end