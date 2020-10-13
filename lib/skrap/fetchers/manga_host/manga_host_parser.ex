defmodule Skrap.Fetchers.MangaHostParser do
  alias Skrap.Content.Manga
  alias Skrap.Fetchers.Parser

  @behaviour Parser

  def manga(html_tree) do
    with {:ok, cover_url} <- get_cover_url(html_tree),
         {:ok, author_name} <- get_author_name(html_tree),
         {:ok, illustrator_name} <- get_illustrator_name(html_tree),
         {:ok, manga_name} <- get_manga_name(html_tree) do
      manga = %Manga{
        author: author_name,
        cover_url: cover_url,
        illustrator: illustrator_name,
        name: manga_name
      }

      {:ok, manga}
    end
  end

  defp get_author_name(html_tree) do
    author =
      html_tree
      |> Floki.find("article .text .box-content div:first-child ul li:nth-child(3) div")
      |> Floki.text(deep: false)

    Parser.validate_field({:author, author})
  end

  defp get_cover_url(html_tree) do
    cover_url =
      html_tree
      |> Floki.find(".box-perfil .widget picture img")
      |> Floki.attribute("src")
      |> List.first()

    Parser.validate_field({:cover_url, cover_url})
  end

  defp get_illustrator_name(html_tree) do
    illustrator =
      html_tree
      |> Floki.find("article .text .box-content div:first-child ul li:nth-child(4) div")
      |> Floki.text(deep: false)

    Parser.validate_field({:illustrator, illustrator})
  end

  defp get_manga_name(html_tree) do
    name =
      html_tree
      |> Floki.find("h1.title")
      |> Floki.text(deep: false)

    Parser.validate_field({:name, name})
  end
end
