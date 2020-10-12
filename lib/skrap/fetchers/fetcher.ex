defmodule Skrap.Fetchers.Fetcher do
  @moduledoc """
  A behavior module for defining a fetcher for a specific host.

  A fetcher is expected to retrieve data from a host.
  """

  alias Skrap.Content.Manga

  @type ok(value) :: {:ok, value}
  @type error :: {:error, term()}

  @callback manga(binary()) :: ok(Manga.t()) | error
end
