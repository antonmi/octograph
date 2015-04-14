defmodule UserSpiderSpec do

	use ESpec

	before do
		Octograph.UserNodeRepo.delete_all
	end

	it do: expect(Octograph.Octo.UserSpider.info.status).to eq(:inactive)

	describe do

		before do
			# allow(Octograph.UserNodeRepo).to accept(:find_or_create_by, fn(login, user) ->
			# 	IO.inspect login
			# end)

			# allow(Octograph.Octo.Client).to accept(:users, fn(_) -> 
			# 	IO.inspect "====="
			# 	:timer.sleep(100)
			# 	[%{login: "login", github_id: 100500}]
			# end)
			pid = Octograph.Octo.UserSpider.start
			{:ok, pid: pid}
		end

		it do
			:timer.sleep(500)
			expect(Octograph.Octo.UserSpider.info.status).to eq(:active)			
			# expect(Octograph.Octo.Client).to accepted(:users, :any, pid: __.pid)
			Octograph.Octo.UserSpider.stop
			:timer.sleep(3000)
			# expect(Octograph.Octo.Client).to accepted(:users, :any, pid: __.pid, count: 1)
			expect(Octograph.UserNodeRepo.count).to be :>=, 100
			IO.inspect Octograph.UserNodeRepo.last
		end


	end
	
end