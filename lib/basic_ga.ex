defmodule BasicGA do
  require Chromosome 

  # @doc "Computes the fitness value for a given chrmosome"
  @spec evaluate(Chromosome.t, Function) :: Chromosome.t
  # @doc "Computes the uniform crossover for two given chromosomes"
  @spec uniform_crossover(Chromosome.t, Chromosome.t) :: List
  # @doc "Computes the discrete mutation for the genes in a given chromosome"
  @spec discrete_mutation(Chromosome.t, Map, Map) :: Chromosome.t
  
  def uniform_crossover(chromo_x, chromo_y) do
    [chromo_x, chromo_y]
  end
  
  def discrete_mutation(chromo, lower_bounds, upper_bounds) do
    # position = Randomise.integer_random(Enum.count(chromo[:genes]))
    # new_gene = 
    chromo
  end
  
   def evaluate(chromo, fitness_function) do
    %{ genes: chromo[:genes],
      fitness: fitness_function.(chromo[:genes]),
      norm_fitness: chromo[:norm_fitness],
      probability: chromo[:probability],
      snr: chromo[:snr],
      fitness_sum: chromo[:fitness_sum] }
  end
  
end