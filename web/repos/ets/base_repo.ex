defmodule Octograph.Ets.BaseRepo do

	defmacro __using__(_opts) do
		quote do

			def create(user_nodes) when is_list(user_nodes) do
				user_nodes = Enum.map(user_nodes, fn(un) -> {un.id, un} end)
				:ets.insert(@table, user_nodes)
			end
				
			def create(user_node), do: create([user_node])

			def all do
				:ets.tab2list(@table)
				|> Enum.map fn{id, model} -> model end
			end

			def count do
				Keyword.get(info, :size)
			end

			def info do
				:ets.info(@table)
			end

		end
	end    

	def start do
		:ets.new(:user_nodes, [:named_table, :set, :public])
		:ets.new(:follow_edges, [:named_table, :set, :public])
	end
end