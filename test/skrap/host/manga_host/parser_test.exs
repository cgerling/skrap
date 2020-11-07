defmodule Skrap.Host.MangaHost.ParserTest do
  use ExUnit.Case, async: true

  alias Skrap.Content.{Chapter, Manga}
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

  describe "chapter/1" do
    test "returns ok with all parsed information" do
      %{data: data, content: content} = HostContent.manga_host(:chapter)

      assert {:ok, %Chapter{} = chapter} = Parser.chapter(content)
      assert chapter.added_at == data.added_at
      assert chapter.id == data.id
      assert chapter.name == data.name
      assert chapter.uri == data.uri
    end

    test "returns and error with a reason when some information could not be parsed" do
      empty_html_tree = []
      assert {:error, {:added_at, :invalid_date_format}} == Parser.chapter(empty_html_tree)
    end
  end

  describe "summary/1" do
    test "returns a list of chapters" do
      %{data: data, content: content} = HostContent.manga_host(:summary)

      chapters = Parser.summary(content)
      assert data.length == Enum.count(chapters)
    end

    test "returns a list of valid chapters when some chapters could not be parsed" do
      invalid_chapter = {}
      invalid_chapters = [invalid_chapter]
      invalid_chapters_length = Enum.count(invalid_chapters)

      %{data: data, content: content} =
        HostContent.manga_host(:summary, chapters: invalid_chapters)

      chapters = Parser.summary(content)

      valid_chapters_length = data.length - invalid_chapters_length
      assert valid_chapters_length == Enum.count(chapters)
    end

    test "returns an empty list when there no item could be parsed" do
      empty_html_tree = []
      assert [] == Parser.summary(empty_html_tree)
    end
  end
end
