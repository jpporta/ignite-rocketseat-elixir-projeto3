defmodule ReportsGenerator do
  alias ReportsGenerator.Parser

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(%{users: %{}, foods: %{}}, fn record, report ->
      sum_values(record, report)
    end)
  end

  defp sum_values([id, food, price], %{:users => users, :foods => foods} = report) do
    user_acc = Map.get(users, id, 0)
    food_acc = Map.get(foods, food, 0)
    users_sum = Map.put(users, id, user_acc + price)
    foods_sum = Map.put(foods, food, food_acc + 1)
    %{report | :users => users_sum, :foods => foods_sum}
  end

  # highest price accumulated by user
  def fetch_higher_cost(%{:users => users, :foods => foods}) do
    user_max = Enum.max_by(users, fn {_key, value} -> value end)
    food_max = Enum.max_by(foods, fn {_key, value} -> value end)
    %{users: user_max, foods: food_max}
  end
end
