defmodule BasicGA do
  require Chromosome
  require InputData

  @moduledoc "Basic Genetic Algorithm"

  @spec evaluate(Chromosome.t, InputData.t) :: Chromosome.t

  @spec uniform_crossover(Chromosome.t, Chromosome.t) :: List

  @spec discrete_mutation(Chromosome.t, InputData.t) :: Chromosome.t

  @spec tournament_selection(Map, Integer, List, InputData.t) :: List
  
  @spec crossover(List, List, InputData.t) :: List
  
  def crossover( [], crossed_individuals, input_data) do
    crossed_individuals
  end
  
  @doc """ 
        Crossover operation method
      """
  def crossover( selected_inviduals, crossed_individuals, input_data ) do
    case input_data.cross_type do
      :uniform -> chromo_1 = hd selected_inviduals
                  chromo_2 = hd tl(selected_inviduals)
                  { new_chromo_1, new_chromo_2 } = uniform_crossover chromo_1, chromo_2
                  crossover( tl(tl (selected_inviduals)), 
                             [ new_chromo_1 | [ new_chromo_2 | crossed_individuals ] ],
                             input_data )
      :one_cut_point -> raise "Not implemented yet"
    end
  end
  
  

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
  def discrete_mutation(chromo, input_data) do
    size = chromo.size
    index = Randomise.integer_random_range(0, size, false)
    u = input_data.upper_bounds[index]
    l = input_data.lower_bounds[index]
    new_value = Randomise.random_range(l, u, true)
    new_genes = %{ chromo.genes | index => new_value }
    new_chromo = %{ chromo | genes: new_genes }
    new_chromo
  end

  @doc """
        Fitness evaluation function
       """
  def evaluate(chromo, input_data) do
    %{  genes: chromo.genes,
        fitness: input_data.fit_function.(chromo.genes, chromo.size),
        norm_fitness: chromo.norm_fitness,
        probability: chromo.probability,
        snr: chromo.snr,
        fitness_sum: chromo.fitness_sum }
  end

  @doc """
        Tournament selection operation
       """
  def tournament_selection( population, k, selected_inviduals,
                            input_data) when k > 0 do
    pop_size = input_data.pop_size
    chromo_1 = population[ Randomise.integer_random_range( 0, 
                                                           input_data.pop_size, 
                                                           false ) ]
    chromo_2 = population[ Randomise.integer_random_range( 0, 
                                                           input_data.pop_size, 
                                                           false ) ]
    case input_data.maximization? do
      :true -> if chromo_1.fitness > chromo_2.fitness do 
                  tournament_selection( population, k - 1, 
                                        [ chromo_1 | selected_inviduals ], 
                                        input_data )
               else
                  tournament_selection( population, k - 1, 
                                        [ chromo_2 | selected_inviduals ], 
                                        input_data )
               end
      :false -> if chromo_1.fitness < chromo_2.fitness do 
                  tournament_selection( population, k - 1, 
                                        [ chromo_1 | selected_inviduals ], 
                                        input_data )
               else
                  tournament_selection( population,  k - 1,
                                        [ chromo_2 | selected_inviduals ],
                                        input_data )
               end
    end
  end

  def tournament_selection( population, k, selected_inviduals, 
                            input_data ) when k == 0 do 
    selected_inviduals 
  end

end