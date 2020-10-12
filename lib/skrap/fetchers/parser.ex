defmodule Skrap.Fetchers.Parser do
  @moduledoc """
  A behaviour module for defining Skrap Parsers.

  A parser is responsible for extracting information of a host.
  """

  alias Skrap.Content.Manga

  @type ok(value) :: {:ok, value}
  @type error(reason) :: {:error, reason}
  @type error :: error(term())

  @callback manga(Floki.html_tree()) :: ok(Manga.t()) | error
end
