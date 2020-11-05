defmodule Skrap.Host.MangaHost.ParserTest do
  use ExUnit.Case, async: true

  alias Skrap.Content.Manga
  alias Skrap.Host.MangaHost.Parser

  alias Skrap.Factory.HostContent

  describe "manga/1" do
    test "returns ok with all parsed information" do
      %{data: data, content: content} = HostContent.manga_host(:manga)

      assert {:ok, %Manga{} = manga} = Parser.manga(content)
      assert manga.author == data.author
      assert manga.cover_url == data.cover_url
      assert manga.illustrator == data.illustrator
      assert manga.name == data.name
    end

    test "returns an error with a reason when some information could not be parsed" do
      empty_html_tree = []
      assert {:error, {:cover_url, :field_not_found}} == Parser.manga(empty_html_tree)
    end
  end
end
