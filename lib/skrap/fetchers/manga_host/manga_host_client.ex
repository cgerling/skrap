defmodule Skrap.Fetchers.MangaHostClient do
  use Skrap.Fetchers.Client, hostname: "https://mangahost2.com"

  def manga(id) when is_binary(id), do: get("/manga/#{id}")
end
