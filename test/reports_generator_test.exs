defmodule ReportsGeneratorTest do
  use ExUnit.Case

  describe "build/1" do
    test "should be able to build the reports" do
      # SETUP
      file_name = "report_test.csv"

      # EXERCISE
      response = ReportsGenerator.build(file_name)

      expected_response = %{
        "foods" => %{
          "açaí" => 1,
          "churrasco" => 2,
          "esfirra" => 3,
          "hambúrguer" => 2,
          "pastel" => 0,
          "pizza" => 2,
          "prato_feito" => 0,
          "sushi" => 0
        },
        "users" => %{
          "1" => 48,
          "10" => 36,
          "11" => 0,
          "12" => 0,
          "13" => 0,
          "14" => 0,
          "15" => 0,
          "16" => 0,
          "17" => 0,
          "18" => 0,
          "19" => 0,
          "2" => 45,
          "20" => 0,
          "21" => 0,
          "22" => 0,
          "23" => 0,
          "24" => 0,
          "25" => 0,
          "26" => 0,
          "27" => 0,
          "28" => 0,
          "29" => 0,
          "3" => 31,
          "30" => 0,
          "4" => 42,
          "5" => 49,
          "6" => 18,
          "7" => 27,
          "8" => 25,
          "9" => 24
        }
      }

      # ASSERTION
      assert response == expected_response
    end
  end

  describe "build_from_parallel/1" do
    test "should be able to build the reports in parallel" do
      # SETUP
      file_names = ["report_test.csv", "report_test.csv"]

      # EXERCISE
      response = ReportsGenerator.build_from_parallel(file_names)

      expected_response = %{
        "foods" => %{
          "açaí" => 2,
          "churrasco" => 4,
          "esfirra" => 6,
          "hambúrguer" => 4,
          "pastel" => 0,
          "pizza" => 4,
          "prato_feito" => 0,
          "sushi" => 0
        },
        "users" => %{
          "1" => 96,
          "10" => 72,
          "11" => 0,
          "12" => 0,
          "13" => 0,
          "14" => 0,
          "15" => 0,
          "16" => 0,
          "17" => 0,
          "18" => 0,
          "19" => 0,
          "2" => 90,
          "20" => 0,
          "21" => 0,
          "22" => 0,
          "23" => 0,
          "24" => 0,
          "25" => 0,
          "26" => 0,
          "27" => 0,
          "28" => 0,
          "29" => 0,
          "3" => 62,
          "30" => 0,
          "4" => 84,
          "5" => 98,
          "6" => 36,
          "7" => 54,
          "8" => 50,
          "9" => 48
        }
      }

      # ASSERTION
      assert response == expected_response
    end

    test "should not be able to build the reports in parallel" do
      # EXERCISE
      response = ReportsGenerator.build_from_parallel("error")

      expected_response = {:error, "Please provide a list of strings"}
      # ASSERTION
      assert response == expected_response
    end
  end

  describe "fetch_higher_cost/2" do
    test "should be able to return with option 'users' the user who spent the most" do
      file_name = "report_test.csv"

      response =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost("users")

      expected_response = {:ok, {"5", 49}}

      assert response == expected_response
    end

    test "should be able to return with option 'foods' the most consumed food" do
      file_name = "report_test.csv"

      response =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost("foods")

      expected_response = {:ok, {"esfirra", 3}}

      assert response == expected_response
    end

    test "should be able to return with invalid option an error" do
      file_name = "report_test.csv"

      response =
        file_name
        |> ReportsGenerator.build()
        |> ReportsGenerator.fetch_higher_cost("invalid-option")

      expected_response = {:error, "Invalid option!"}

      assert response == expected_response
    end
  end
end
