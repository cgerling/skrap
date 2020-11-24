defmodule SkrapTest do
  use ExUnit.Case

  describe "fetch_manga/1" do
    @tag :wip
    test "returns ok with manga information of the given url" do
      manga_url = "http://fanfox.net/manga/onepunch_man/"

      manga_info = Skrap.fetch_manga(manga_url)

      assert manga_info.name == "Onepunch-Man"
      assert manga_info.url == manga_url
      assert manga_info.author == "ONE"
      refute Enum.empty?(manga_info.chapters)

      assert Enum.all?(manga_info.chapters, fn chapter ->
               Map.keys(chapter) == [:name, :release_date, :url]
             end)
    end

    test "returns an error with a reason when no manga could be found from the given url"
  end
end
