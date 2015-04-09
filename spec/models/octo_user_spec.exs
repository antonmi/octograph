defmodule OctoUserSpec do

	use ESpec

	alias Octograph.OctoUser

	before do
	  antonmi = Octograph.Octo.Client.users("antonmi")
 		octo_user = OctoUser.build(antonmi)
 		{:ok, antonmi: antonmi, octo_user: octo_user}
	end

	it "check octo_user" do
		IO.inspect __.antonmi
		IO.inspect __.octo_user
	end
	

end