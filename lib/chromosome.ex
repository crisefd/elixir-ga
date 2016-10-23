defmodule Chromosome do
  defstruct [:genes, :fitness, :norm_fitness, :probability, :snr, :fitness_sum]
  @type chromosome ::  %__MODULE__{ genes: List, fitness: Float, 
                                    norm_fitness: Float, probability: Float,
                                    snr: Float, fitness_sum: Float }
end
  
