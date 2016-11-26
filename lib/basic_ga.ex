defmodule BasicGA do
  require Chromosome

  @moduledoc "Basic Genetic Algorithm"

  @spec evaluate(Chromosome.t, Function) :: Chromosome.t

  @spec uniform_crossover(Chromosome.t, Chromosome.t) :: List

  @spec discrete_mutation(Chromosome.t, Map, Map) :: Chromosome.t

#  @spec uniform_crossover_aux(Map, Map, Integer, Integer) :: Any
  
  @doc """
        Computes the uniform crossover for two given chromosomes
       """
  def uniform_crossover(chromo_x, chromo_y) do
    r = uniform_crossover( chromo_x.genes,
                           chromo_y.genes,
                           chromo_x.genes,
                           chromo_y.genes,
                           chromo_x.size - 1 )
    { %{ chromo_x | genes: elem(r, 0)}, %{ chromo_y | genes: elem(r, 1)} }
  end

  def uniform_crossover(x, y, x_, y_, i) when i >= 0 do
    p = Randomise.integer_random_range 0, 1, true
    case p do
      0 -> uniform_crossover( x, y, %{ x_ | i => y[i] }, y_, i - 1 )
      1 -> uniform_crossover( x, y, x_, %{ y_ | i => x[i] }, i - 1 )
    end
  end

  def uniform_crossover(x, y, x_, y_, i) when -1 == i,  do: { x_, y_ }

  @doc """
        Computes the discrete mutation for the genes in a given chromosome
      """
  def discrete_mutation(chromo, upper_bounds, lower_bounds) do
    size = chromo.size
    index = Randomise.integer_random_range(0, size, false)
    u = upper_bounds[index]
    l = lower_bounds[index]
    new_value = Randomise.random_range(l, u, true)
    new_genes = %{ chromo.genes | index => new_value }
    new_chromo = %{ chromo | genes: new_genes }
    new_chromo
  end
  
  @doc """
        Fitness evaluation function
       """
  def evaluate(chromo, fitness_function) do
    %{  genes: chromo.genes,
        fitness: fitness_function.(chromo.genes, chromo.size),
        norm_fitness: chromo.norm_fitness,
        probability: chromo.probability,
        snr: chromo.snr,
        fitness_sum: chromo.fitness_sum }
  end
  
end