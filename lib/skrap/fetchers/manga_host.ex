defmodule Skrap.Fetchers.MangaHost do
  alias Skrap.Content.Manga
  alias Skrap.Fetchers.{MangaHostClient, MangaHostParser, Parser}

  @behaviour Skrap.Fetchers.Fetcher

  def manga(id) when is_binary(id) do
    with {:ok, response} <- MangaHostClient.manga(id),
         {:ok, manga} <- MangaHostParser.manga(response.body) do
      {:ok, %Manga{manga | id: id}}
    end
  end
end
