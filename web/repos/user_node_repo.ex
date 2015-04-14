defmodule Octograph.UserNodeRepo do
	use Octograph.BaseRepo

	def find_by_login(login) do
		query = from un in Octograph.UserNode, where: un.login == ^login, select: un
    Octograph.Repo.all(query) |> List.first
	end

	def update_or_create(user_node) do
		user = find_by_login(user_node.login)
		if user do
			user = update(%{user_node | id: user.id})
		else
			user = create(user_node)
		end
		user
	end

	def sample do
		offset = :random.uniform(count)
		query = from un in Octograph.UserNode, limit: 1, offset: ^offset
    Octograph.Repo.one(query)
	end

	def last_by_github_id do
    query = from(un in module, order_by: [desc: :github_id], limit: 1)
    Octograph.Repo.one(query)
  end

  def without_followers do
		query = from(un in module, where: is_nil(un.followers_checked_at), select: un, limit: 100)
    Octograph.Repo.all(query)
  end
	

end