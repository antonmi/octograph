defmodule Octograph.OctoUser do

	defstruct _id: nil, github_id: nil, data: %{}

	def build(data) do
		id = "github_#{data["id"]}"
		{:ok, d} = Poison.encode(data)
		%Octograph.OctoUser{_id: id, github_id: data["id"], data: d}
	end

end