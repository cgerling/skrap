defmodule Skrap.Fetcher.MangaHost do
  alias Skrap.Content.Manga
  alias Skrap.Fetcher
  alias Skrap.Host.MangaHost.{Client, Parser}
  alias Tesla.Env

  @behaviour Fetcher

  @impl Fetcher
  def manga(id) when is_binary(id) do
    with {:ok, %Env{body: body}} <- Client.manga(id),
         {:ok, %Manga{} = manga} <- Parser.manga(body) do
      {:ok, %Manga{manga | id: id}}
    end
  end
end
