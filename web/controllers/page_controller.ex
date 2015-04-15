defmodule Octograph.PageController do
  use Octograph.Web, :controller

  plug :action

  def index(conn, _params) do
    {nodes, edges} = Octograph.Traverser.level(3)
    {nodes, edges} = {Enum.uniq(nodes), Enum.uniq(edges)}
    render conn, "index.html", nodes: nodes, edges: edges
  end
end
