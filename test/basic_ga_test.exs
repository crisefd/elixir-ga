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
    
    assert BasicGA.evaluate(chromo, 
                            %{ fitness_function: fitness_function,
                               maximization?: true } ).fitness == 6
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
  
  @tag :skip
  test_with_mock  "uniform crossover with mocks of two chromosomes",
                  BasicGA,
                  [],
                  [ generate_probabilities_for_crossover: fn(6, []) -> [0, 1, 0, 1, 0, 1] end ] do

    chromo_x = %{ genes: %{ 0 => 1, 1 => 2, 2 => 3, 3 => 4, 4 => 5, 5 => 6}, fitness: nil,
                  norm_fitness: nil, probability: nil, snr: nil,
                  fitness_sum: nil, size: 6 }
    chromo_y = %{ genes: %{ 0 => -4, 1 => -5, 2 => -6, 3 => -7, 4 => -8, 5 => -9}, fitness: nil,
                  norm_fitness: nil, probability: nil, snr: nil, 
                  fitness_sum: nil, size: 6 }
    { new_chromo_x , new_chromo_y } = BasicGA.uniform_crossover chromo_x, chromo_y
    assert new_chromo_x.genes == %{0 => 1, 1 => -5, 2 => -6, 3 => -7, 4 => 5, 5 => 6}
    assert new_chromo_y.genes == %{0 => -4, 1 => 2, 2 => 3, 3 => 4, 4 => -8, 5 => -9}
  end

  test  "uniform crossover of two chromosomes" do
    chromo_x = %{ genes: %{ 0 => 1, 1 => 2, 2 => 3, 3 => 4, 4 => 5, 5 => 6 },
                  fitness: nil, norm_fitness: nil, probability: nil, snr: nil,
                  fitness_sum: nil, size: 6 }
    chromo_y = %{ genes: %{ 0 => -4, 1 => -5, 2 => -6, 3 => -7, 4 => -8, 5 => -9 },
                  fitness: nil, norm_fitness: nil, probability: nil, snr: nil, 
                  fitness_sum: nil, size: 6 }
    { new_chromo_x , new_chromo_y } = BasicGA.uniform_crossover chromo_x, chromo_y
    assert new_chromo_x != chromo_x
    assert new_chromo_y != chromo_y
  end
  
  test " tournament selection with k = 2" do
    population = %{ 0 => %{ genes: %{}, fitness: 5, norm_fitness: nil,
                            probability: nil, fitness_sum: nil, snr: nil,
                            size: nil },
                    1 => %{ genes: %{}, fitness: 6, norm_fitness: nil,
                            probability: nil, fitness_sum: nil, snr: nil,
                            size: nil },
                    2 => %{ genes: %{}, fitness: 4, norm_fitness: nil,
                            probability: nil, fitness_sum: nil, snr: nil,
                            size: nil },
                    3 => %{ genes: %{}, fitness: 0, norm_fitness: nil,
                            probability: nil, fitness_sum: nil, snr: nil,
                            size: nil },
                    4 => %{ genes: %{}, fitness: 15, norm_fitness: nil,
                            probability: nil, fitness_sum: nil, snr: nil,
                            size: nil },
                    5 => %{ genes: %{}, fitness: -7, norm_fitness: nil,
                            probability: nil, fitness_sum: nil, snr: nil,
                            size: nil },
                  }
    pop_size = 6
    k = 2
    problem = %{ fitness_function: nil, maximization?: true }
    result = BasicGA.tournament_selection population, pop_size, k, [], problem
    IO.inspect result
    assert true
  end

end
