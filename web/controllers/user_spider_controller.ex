defmodule Octograph.UserSpiderController do
  use Octograph.Web, :controller

  plug :action

  def show(conn, _params) do
  	info = Octograph.Octo.UserSpider.info
  	render conn, "show.html", info: info
  end

  def start(conn, _params) do
  	Octograph.Octo.UserSpider.start
 		conn |> put_flash(:notice, "UserSpider started!")
    |> redirect to: user_spider_path(conn, :show)
  end

   def stop(conn, _params) do
  	Octograph.Octo.UserSpider.stop
 		conn |> put_flash(:notice, "UserSpider stopped!")
    |> redirect to: user_spider_path(conn, :show)
  end


end