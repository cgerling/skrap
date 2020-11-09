defmodule Skrap.Host.MangaHost.Parser do
  alias Skrap.Content.{Chapter, Manga}
  alias Skrap.DateHelper
  alias Skrap.Host.Parser

  @behaviour Parser

  @impl Parser
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

  @impl Parser
  def summary(html_tree) do
    html_tree
    |> Floki.find(".chapters > .cap")
    |> Enum.map(&chapter/1)
    |> Enum.reject(&match?({:error, _}, &1))
    |> Enum.map(fn {:ok, chapter} -> chapter end)
    |> Enum.reverse()
  end

  @impl Parser
  def chapter(html_node) do
    with {:ok, added_at} <- get_added_at(html_node),
         {:ok, id} <- get_chapter_id(html_node),
         {:ok, name} <- get_chapter_name(html_node),
         {:ok, uri} <- get_chapter_uri(html_node) do
      chapter = %Chapter{
        added_at: added_at,
        id: id,
        name: name,
        uri: uri
      }

      {:ok, chapter}
    end
  end

  defp get_added_at(html_node) do
    added_at_text =
      html_node
      |> Floki.find(".card.pop .pop-content > small")
      |> Floki.text(deep: false)

    added_at_readable_date =
      added_at_text
      |> String.split(" ")
      |> Enum.take(-3)
      |> Enum.join(" ")

    case DateHelper.parse_readable_date(added_at_readable_date) do
      {:ok, %Date{} = date} -> {:ok, date}
      {:error, reason} -> {:error, {:added_at, reason}}
    end
  end

  defp get_chapter_id(html_node) do
    id =
      html_node
      |> Floki.find(".card.pop .pop-title > span")
      |> Floki.text(deep: false)
      |> String.trim()

    Parser.validate_field({:id, id})
  end

  defp get_chapter_name(html_node) do
    name =
      html_node
      |> Floki.find("a[data-pop]")
      |> Floki.attribute("title")
      |> List.first()
      |> String.trim()

    Parser.validate_field({:name, name})
  end

  defp get_chapter_uri(html_node) do
    uri =
      html_node
      |> Floki.find(".card.pop .pop-content > .tags > a")
      |> Floki.attribute("href")
      |> List.first()

    Parser.validate_field({:uri, uri})
  end
end
