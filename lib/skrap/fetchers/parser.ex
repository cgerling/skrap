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

  @spec parse_html(String.t()) :: ok(Floki.html_tree()) | error(String.t())
  def parse_html(document) when is_binary(document) do
    Floki.parse_document(document)
  end
end
