defmodule BasicGaTest do
  use ExUnit.Case, async: false
  doctest BasicGA

  import Mock

  test "fitness evaluation of chromosome" do
    chromo = %{ genes: %{ 0 => 1, 1 => 2, 2 => 3}, fitness: nil,
                norm_fitness: nil, probability: nil, snr: nil, fitness_sum: nil, 
                size: 3 }
    fitness_function = fn(x, n) ->
      defmodule TestFuncion do
        def fit_func_aux(genes, index, lim, acc) when index == lim do
          acc + genes[index]
        end
        def fit_func_aux(genes, index, lim, acc) when index < lim do
          fit_func_aux genes, index + 1, lim, acc + genes[index]
        end
      end
      res = TestFuncion.fit_func_aux x, 0, n - 1, 0
      res
    end
    assert BasicGA.evaluate(chromo, fitness_function).fitness == 6
  end
  
  test_with_mock "discrete mutation of chromosome",
                 Randomise,
                 [],
                 [ random_range: fn(_a, _b, _inc) -> 3.0 end,
                   integer_random_range: fn(_a, _b, _inc) -> 2 end ] do
    chromo = %{ genes: %{ 0 => 1, 1 => 2, 2 => 4 },
                fitness: nil,
                norm_fitness: nil,
                probability: nil,
                snr: nil,
                fitness_sum: nil,
                size: 3 }
    upper_bounds = %{ 0 => 5, 1 => 5, 2 => 5 }
    lower_bounds = %{ 0 => 1, 1 => 1, 2 => 1}
    mutated_chromo = BasicGA.discrete_mutation chromo, upper_bounds, lower_bounds
    assert mutated_chromo != chromo
    assert called Randomise.random_range(1, 5, true)
    assert called Randomise.integer_random_range(0, 3, false)
  end
end
