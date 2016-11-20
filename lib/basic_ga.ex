defmodule BasicGA do
  require Chromosome 
  @type array :: :array
  # @doc "Computes the fitness value for a given chrmosome"
  @spec evaluate(Chromosome.t, Function) :: Chromosome.t
  # @doc "Computes the uniform crossover for two given chromosomes"
  @spec uniform_crossover(Chromosome.t, Chromosome.t) :: List
  # @doc "Computes the discrete mutation for the genes in a given chromosome"
  @spec discrete_mutation(Chromosome.t, array, array) :: Chromosome.t
  
  def uniform_crossover(chromo_x, chromo_y) do
    [chromo_x, chromo_y]
  end
  
  def discrete_mutation(chromo, upper_bounds, lower_bounds) do
    index = Randomise.sample_index(chromo[:genes])
    u = :array.get(upper_bounds, index)
    l = :array.get(lower_bounds, index)
    new_value = Randomise.random_range(l, u, true)
    :array.set(index, new_value, chromo[:genes])
    chromo
  end
  
  @doc " Fitness evaluation function"
  def evaluate(chromo, fitness_function) do
    %{  genes: chromo[:genes],
        fitness: fitness_function.(chromo[:genes]),
        norm_fitness: chromo[:norm_fitness],
        probability: chromo[:probability],
        snr: chromo[:snr],
        fitness_sum: chromo[:fitness_sum] }
  end
  
end