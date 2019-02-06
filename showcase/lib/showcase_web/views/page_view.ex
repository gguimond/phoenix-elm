defmodule ShowcaseWeb.PageView do
  use ShowcaseWeb, :view

  def render("index.json", %{pages: pages}) do
    %{data: render_many(pages, ShowcaseWeb.PageView, "page.json")}
  end

  def render("page.json", %{page: page}) do
    %{title: page.title}
  end
end
