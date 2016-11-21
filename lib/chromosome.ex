defmodule Chromosome do

   @moduledoc """
      Contains the data type definition of the Chromosome
    """

  defstruct [:genes, :fitness, :norm_fitness, :probability, :snr, :fitness_sum,
             :size]
  
  @typedoc """
    Data structure to code solutions
  """
  @type chromosome ::  %__MODULE__{ genes: Map,
                                    fitness: Float, 
                                    norm_fitness: Float,
                                    probability: Float,
                                    snr: Float, 
                                    fitness_sum: Float, 
                                    size: Integer }
end