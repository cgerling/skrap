defmodule Skrap.Host.Parser do
  @moduledoc """
  A behaviour module for defining Skrap Parsers.

  A parser is responsible for extracting information of a host.
  """

  alias Skrap.Content.{Chapter, Manga}

  @type ok(value) :: {:ok, value}
  @type error(reason) :: {:error, reason}
  @type error :: error(term())
  @type maybe_string :: String.t() | nil

  @callback manga(Floki.html_tree()) :: ok(Manga.t()) | error
  @callback summary(Floki.html_tree()) :: list(Chapter.t())
  @callback chapter(Floki.html_node()) :: ok(Chapter.t()) | error

  @invalid_field_values [nil, ""]

  @spec validate_field({atom(), maybe_string()}) :: ok(String.t()) | error({atom(), atom()})
  def validate_field({field, value}) when value in @invalid_field_values,
    do: {:error, {field, :field_not_found}}

  def validate_field({_, value}), do: {:ok, value}
end
