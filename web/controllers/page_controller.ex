defmodule Octograph.PageController do
  use Octograph.Web, :controller

  plug :action

  def index(conn, _params) do
  	nodes = Octograph.UserNodeRepo.all
  	edges = Octograph.FollowEdgeRepo.all
    render conn, "index.html", nodes: nodes, edges: edges
  end
end
