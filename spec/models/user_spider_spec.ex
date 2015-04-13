defmodule UserSpiderSpec do

	use Espec

	describe do

		it do
			pid = Octograph.Octo.UserSpider.start

			:timer.sleep(5000)
		end

	end 

end