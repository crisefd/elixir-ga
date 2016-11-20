defmodule BasicGaTest do
  use ExUnit.Case
  doctest BasicGA

  test "fitness evaluation of chromosome" do
    chromo = %{ genes: [1, 2, 3], fitness: nil, norm_fitness: nil,
                probability: nil, snr: nil, fitness_sum: nil }
    fitness_function = fn(x) -> Enum.reduce(x, fn(xi, acc) -> xi + acc end) end
    assert(BasicGA.evaluate(chromo, fitness_function).fitness == 6)
  end
  
  test "discrete mutation of chromosome" do
    chromo = %{ genes: [1, 2, 3], fitness: nil, norm_fitness: nil,
                probability: nil, snr: nil, fitness_sum: nil }
    upper_bounds = [5, 5, 5]
    lower_bounds = [1, 1, 1]
    actual = BasicGA.discrete_mutation(chromo, upper_bounds, lower_bounds)
    assert(actual != nil)
  end
end
