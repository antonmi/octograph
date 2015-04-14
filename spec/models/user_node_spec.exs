defmodule UserNodeSpec do

	use ESpec 

	describe "new" do
		let! :data do
			%{"login" => "test", "id" => 100500}
		end

		let! :user_node, do: Octograph.UserNode.new(data)

		it "check user_node" do
			expect(user_node.login).to eq("test")
			expect(user_node.github_id).to eq(100500)
		end
	end
end