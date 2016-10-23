defmodule ChromosomeTest do
  use ExUnit.Case
  doctest Chromosome
  
  test "fitness evaluation of chromosome" do
    chromo = %{ genes: [1, 2, 3], fitness: nil, norm_fitness: nil, 
                probability: nil, snr: nil, fitness_sum: nil }
    fitness_function = fn(x) -> Enum.reduce(x, fn(xi, acc) -> xi + acc end) end
    assert(Chromosome.evaluate(chromo, fitness_function).fitness == 6)
  end
end