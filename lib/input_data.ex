defmodule InputData do

  @moduledoc """
    Contains the input data for the GA
  """
  defstruct [ :cross_rate, :mut_rate, :cross_type, :mut_type, :pop_size,
              :num_genes, :upper_bounds, :lower_bounds, :maximization?,
              :fit_function ]

  @typedoc """
    Optimization problem codification
  """
  @type input_data :: %__MODULE__{ cross_rate: Float,
                                   mut_rate: Float,
                                   cross_type: Atom,
                                   mut_type: Atom,
                                   pop_size: Integer,
                                   num_genes: Integer,
                                   upper_bounds: Map,
                                   lower_bounds: Map,
                                   maximization?: Boolean,
                                   fit_function: Function }
end