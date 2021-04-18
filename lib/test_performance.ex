defmodule ReportsGenerator.TestPerformance do
  def test_build() do
    {time, _map} = :timer.tc(fn ->
      ReportsGenerator.build("report_complete.csv")
    end)
    time
  end

  def test_build_parallel() do
    {time, _map} = :timer.tc(fn ->
      ReportsGenerator.build_from_parallel(
        [
          "report_1.csv",
          "report_2.csv",
          "report_3.csv"
        ]
      )
    end)
    time
  end
end
