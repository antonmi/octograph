defmodule Octograph.UserNodeRepo do
	use Octograph.BaseRepo

	def find_by_login(login) do
		query = from un in Octograph.UserNode, where: un.login == ^login, select: un
    Octograph.Repo.all(query) |> List.first
	end

	def find_or_create_by(login, github_id) do
		user = find_by_login(login)
		unless user, do: user = create(%Octograph.UserNode{login: login, github_id: github_id})
		user
	end

	def sample do
		offset = :random.uniform(count)
		query = from un in Octograph.UserNode, limit: 1, offset: ^offset
    Octograph.Repo.one(query)
	end

	def last_by_github_id do
    query = from(m in module, order_by: [desc: :github_id], limit: 1)
    Octograph.Repo.one(query)
  end
	

end