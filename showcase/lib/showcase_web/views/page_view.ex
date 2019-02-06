defmodule ShowcaseWeb.PageView do
  use ShowcaseWeb, :view

  def render("index.json", %{pages: pages}) do
    %{data: render_many(pages, ShowcaseWeb.PageView, "page.json")}
  end

  def render("page.json", %{page: page}) do
    %{title: page.title}
  end

  def handler_info(conn) do
    "Request Handled By: #{controller_module(conn)}.#{action_name(conn)}"
  end

  def connection_keys(conn) do
    conn
    |> Map.from_struct()
    |> Map.keys()
  end
  
end
