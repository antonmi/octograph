defmodule Octograph.Octo.UserSpider do

	use GenServer

	def start do
		GenServer.start_link(__MODULE__, [], name: __MODULE__)
		GenServer.cast __MODULE__, :start
	end

	def init(args) do
		{:ok, []}
	end

	def handle_cast(:start, state) do
		last_id = Octograph.OctoUserRepo.last.github_id
	end

	def handle_call(:stop, _pid, state) do
		{:stop, :normal, :ok, state}
	end
end