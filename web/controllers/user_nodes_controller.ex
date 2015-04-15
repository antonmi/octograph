defmodule Octograph.UserNodesController do
  use Octograph.Web, :controller

  plug :action

  def index(conn, _params) do
    user_node = Octograph.UserNodeRepo.last
    count = Octograph.UserNodeRepo.count
    edges_count = Octograph.FollowEdgeRepo.count
    render conn, "index.html", user_node: user_node, count: count, edges_count: edges_count
  end
end
