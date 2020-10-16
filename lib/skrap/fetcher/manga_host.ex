defmodule Skrap.Fetcher.MangaHost do
  alias Skrap.Content.Manga
  alias Skrap.Host.MangaHost.{Client, Parser}

  @behaviour Skrap.Fetcher

  def manga(id) when is_binary(id) do
    with {:ok, response} <- Client.manga(id),
         {:ok, manga} <- Parser.manga(reponse.body) do
      {:ok, %Manga{manga | id: id}}
    end
  end
end
