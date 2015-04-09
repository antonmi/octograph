defmodule Octograph.FollowEdge do

	defstruct id: nil, from: nil, to: nil

	def new(from, to) do
		id = "#{from}_#{to}"
		%__MODULE__{id: id, from: from, to: to}
	end
end