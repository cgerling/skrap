defmodule Skrap.DateHelper do
  @spec parse_readable_date(String.t()) :: {:ok, Date.t()} | {:error, term()}
  def parse_readable_date(
        <<m1::utf8, m2::utf8, m3::utf8, " ", d1::utf8, d2::utf8, ", ", year::binary>>
      ) do
    day = [d1, d2] |> to_string() |> String.to_integer()
    month = [m1, m2, m3] |> to_string() |> parse_month()
    year = String.to_integer(year)

    date = Date.new!(year, month, day)
    {:ok, date}
  end

  def parse_readable_date(_), do: {:error, :invalid_date_format}

  defp parse_month("Jan"), do: 1
  defp parse_month("Feb"), do: 2
  defp parse_month("Mar"), do: 3
  defp parse_month("Apr"), do: 4
  defp parse_month("May"), do: 5
  defp parse_month("Jun"), do: 6
  defp parse_month("Jul"), do: 7
  defp parse_month("Aug"), do: 8
  defp parse_month("Sep"), do: 9
  defp parse_month("Oct"), do: 10
  defp parse_month("Nov"), do: 11
  defp parse_month("Dec"), do: 12
end
