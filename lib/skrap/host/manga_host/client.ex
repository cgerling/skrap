defmodule Skrap.Host.MangaHost.Client do
  use Skrap.Host.Client, hostname: "https://mangahost2.com"

  alias Skrap.Host.Client

  plug Tesla.Middleware.DecodeHTML

  @impl Client
  def manga(id) when is_binary(id), do: get("/manga/#{id}")
end
