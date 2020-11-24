defmodule Skrap do
  def fetch_manga(url) do
    {:ok, env} = Tesla.get(url)
    {:ok, document} = Floki.parse_document(env.body)

    name = fetch_name(document)
    author = fetch_author(document)
    chapters = fetch_chapters(document)

    %{
      url: url,
      name: name,
      author: author,
      chapters: chapters
    }
  end

  defp fetch_name(document) do
    name_selector = ".detail-info .detail-info-right .detail-info-right-title-font"
    fetch_text_content(document, name_selector)
  end

  defp fetch_author(document) do
    author_selector = ".detail-info .detail-info-right .detail-info-right-say a"
    fetch_text_content(document, author_selector)
  end

  defp fetch_chapters(document) do
    chapters_selector = ".detail-main .detail-main-list li"

    document
    |> Floki.find(chapters_selector)
    |> Enum.map(&fetch_chapter/1)
  end

  defp fetch_chapter(element) do
    name = fetch_text_content(element, ".title3")
    release_date = fetch_text_content(element, ".title2")
    url = element |> Floki.find("a") |> Floki.attribute("href") |> List.first()

    %{name: name, url: url, release_date: release_date}
  end

  defp fetch_text_content(html, selector) do
    html |> Floki.find(selector) |> Floki.text(deep: false)
  end
end
