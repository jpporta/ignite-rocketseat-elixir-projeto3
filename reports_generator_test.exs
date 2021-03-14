defmodule ReportsGeneratorTest do
  use ExUnit.Case

  describe "buid/1" do
    test "builds the report" do
      file_name = "report_test.csv"

      response =
        file_name
        |> ReportsGenerator.build()

      expected_response = %{
        foods: %{
          "açaí" => 1,
          "churrasco" => 2,
          "esfirra" => 3,
          "hambúrguer" => 2,
          "pizza" => 2
        },
        users: %{
          "1" => 48,
          "10" => 36,
          "2" => 45,
          "3" => 31,
          "4" => 42,
          "5" => 49,
          "6" => 18,
          "7" => 27,
          "8" => 25,
          "9" => 24
        }
      }

      assert response == expected_response
    end
  end

  describe "fetch_higher_cost/1" do
    test "fecth higher values" do
      file_name = "report_test.csv"

      result =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost()

      expected_result = %{foods: {"esfirra", 3}, users: {"5", 49}}

      assert result == expected_result
    end
  end
end
