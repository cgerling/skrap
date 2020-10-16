defmodule Skrap.Host.ParserTest do
  use ExUnit.Case, async: true

  alias Skrap.Host.Parser

  describe "validate_field/1" do
    @field_name :test_field

    test "returns ok with the value" do
      field_value = "value"
      field = {@field_name, field_value}

      assert {:ok, value} = Parser.validate_field(field)
      assert value == field_value
    end

    test "returns an error with field not found as reason when field value is nil or empty" do
      invalid_values = [nil, ""]

      assert Enum.all?(invalid_values, fn field_value ->
               field = {@field_name, field_value}
               {:error, {@field_name, :field_not_found}} == Parser.validate_field(field)
             end)
    end
  end
end
