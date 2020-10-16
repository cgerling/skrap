defmodule Skrap.Host.MangaHost.Client do
  use Skrap.Host.Client, hostname: "https://mangahost2.com"

  plug Tesla.Middleware.DecodeHTML

  def manga(id) when is_binary(id), do: get("/manga/#{id}")
end
