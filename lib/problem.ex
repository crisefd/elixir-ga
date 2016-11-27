defmodule Problem do
   @moduledoc """
      Contains the data for a problem
    """
    defstruct [:fitness_function, :maximization?]
    
    @type problem :: %__MODULE__{ fitness_function: Function,
                                  maximization?: Boolean }
end