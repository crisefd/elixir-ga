defmodule BasicGA do
  require Chromosome

  @moduledoc "Basic Genetic Algorithm"

  @spec evaluate(Chromosome.t, Function) :: Chromosome.t

  @spec uniform_crossover(Chromosome.t, Chromosome.t) :: List

  @spec discrete_mutation(Chromosome.t, Map, Map) :: Chromosome.t

  @doc """
        Computes the uniform crossover for two given chromosomes
       """
  def uniform_crossover(chromo_x, chromo_y) do
    [chromo_x, chromo_y]
  end
  
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