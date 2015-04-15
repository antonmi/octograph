defmodule Octograph.SpidersController do
  use Octograph.Web, :controller

  plug :set_spider
  plug :action

  def show(conn, params) do
  	info = conn.assigns[:spider_module].info
  	render conn, "show.html", info: info, spider: conn.assigns[:spider]
  end

  def start(conn, _params) do
    spider_module = conn.assigns[:spider_module]
  	spider_module.start
 		conn |> put_flash(:notice, "#{spider_module} started!")
    |> redirect to: spiders_spiders_path(conn, :show, conn.assigns[:spider])
  end

  def stop(conn, _params) do
    spider_module = conn.assigns[:spider_module]
  	spider_module.stop
 		conn |> put_flash(:notice, "#{spider_module} stopped!")
    |> redirect to: spiders_spiders_path(conn, :show, conn.assigns[:spider])
  end

  def set_spider(conn, _opts) do
    cond do
      conn.params["spiders_id"] == "users" ->
        conn |> assign(:spider, "users")
        |> assign(:spider_module, Octograph.Octo.UserSpider)
      conn.params["spiders_id"] == "followers" ->
        conn |> assign(:spider, "followers")
        |> assign(:spider_module, Octograph.Octo.FollowersSpider)
    end
  end





end