defmodule Octograph.UserNodeRepo do
	use Octograph.BaseRepo

	def find_by_login(login) do
		query = from un in Octograph.UserNode, where: un.login == ^login, select: un
    Octograph.Repo.one(query)
	end

	def find_by_logins(logins) do
    query = from r in module, where: r.login in ^logins, select: r
    Octograph.Repo.all(query)
  end


	def find_or_create(user_node) do
		user = find_by_login(user_node.login)
		unless user, do: user = create(user_node)
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

  def with_max_followers do
    query = from(un in module, where: not is_nil(un.flrs_count), order_by: [desc: :flrs_count], limit: 1)
    Octograph.Repo.one(query, timeout: :infinity)
  end

  def first_without_followers do
		query = from(un in module, where: is_nil(un.followers_checked_at), select: un, limit: 1)
    Octograph.Repo.one(query)
  end

  def find_or_create_followers(data) do
  	logins = Enum.map(data, fn(d) -> d["login"] end)
   	stored = find_by_logins(logins)
  	new = Enum.filter(data, fn(d) ->
  		!Enum.any?(stored, fn(u) -> u.login == d["login"] end)
  	end)
  	Enum.each(new, fn(n) -> create(Octograph.UserNode.new(n))	end)
  	find_by_logins(logins)
  end




end