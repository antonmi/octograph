defmodule Octograph.UserNode do

	defstruct id: nil

	def build(data) do
		%__MODULE__{id: data["login"]}
	end
	
end