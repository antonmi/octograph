defmodule Octograph.Octo.Client do

	alias Tentacat.Users

	def me, do: Users.me(client)

	def users, do: Users.list(client)
	def users(since) when is_integer(since), do: Users.list_since(since, client)
	def users(name) when is_binary(name), do: Users.find(name, client)

	defp client, do:	%Tentacat.Client{auth: %{access_token: access_token}}

	defp access_token, do: Application.get_env(:octograph, :github_token)

end