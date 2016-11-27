defmodule BasicGA do
  require Chromosome
  require Problem

  @moduledoc "Basic Genetic Algorithm"

  @spec evaluate(Chromosome.t, Problem.t) :: Chromosome.t

  @spec uniform_crossover(Chromosome.t, Chromosome.t) :: List

  @spec discrete_mutation(Chromosome.t, Map, Map) :: Chromosome.t
  
  @spec tournament_selection(Map, Integer, Integer, List, Problem.t) :: List

  @doc """
        Computes the uniform crossover for two given chromosomes
       """
  def uniform_crossover(chromo_x, chromo_y) do
    r = uniform_crossover( chromo_x.genes,
                           chromo_y.genes,
                           chromo_x.genes,
                           chromo_y.genes,
                           chromo_x.size - 1 )
    { %{ chromo_x | genes: elem(r, 0) }, 
      %{ chromo_y | genes: elem(r, 1) } }
  end

  def generate_probabilities_for_crossover(n, ls) do
    if n == 0 do
      ls
    else
      p = Randomise.integer_random_range 0, 1
      generate_probabilities_for_crossover(n - 1, [p | ls])
    end
  end

  def uniform_crossover(x, y, x_, y_, i) when i >= 0 do
    p = Randomise.integer_random_range 0, 1, true
    case p do
      0 -> uniform_crossover( x,
                              y, 
                              %{ x_ | i => y[i] },
                              %{ y_ | i => x[i] },
                              i - 1 )
      1 -> uniform_crossover( x,
                              y, 
                              x_,
                              y_,
                              i - 1 )
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
  def evaluate(chromo, problem) do
    %{  genes: chromo.genes,
        fitness: problem.fitness_function.(chromo.genes, chromo.size),
        norm_fitness: chromo.norm_fitness,
        probability: chromo.probability,
        snr: chromo.snr,
        fitness_sum: chromo.fitness_sum }
  end

  def tournament_selection(population, pop_size, k,
                           selected_inviduals, problem) when k > 0 do
    chromo_1 = population[Randomise.integer_random_range(0, pop_size, false)]
    chromo_2 = population[Randomise.integer_random_range(0, pop_size, false)]
    case problem.maximization? do
      :true -> if chromo_1.fitness > chromo_2.fitness do 
                  tournament_selection( population, pop_size, k - 1, 
                                          [ chromo_1 | selected_inviduals ], 
                                          problem )
               else
                  tournament_selection( population, pop_size, k - 1, 
                                        [ chromo_2 | selected_inviduals ], 
                                        problem )
               end
      :false -> if chromo_1.fitness < chromo_2.fitness do 
                  tournament_selection( population, pop_size, k - 1, 
                                          [ chromo_1 | selected_inviduals ], 
                                          problem )
               else
                  tournament_selection( population, pop_size, k - 1,
                                        [ chromo_2 | selected_inviduals ],
                                        problem )
               end
    end
  end

  def tournament_selection(population, pop_size, k, selected_inviduals, problem)
    when k == 0 do 
    selected_inviduals 
  end

end