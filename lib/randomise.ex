defmodule Randomise do
  @moduledoc """
    Wrapper module for the SFMT pseudo random generator
  """
  @on_load :reseed_generator 

  def reseed_generator do 
    :sfmt.seed(:os.timestamp())
    :ok
  end 

  def integer_random(number) do
    :sfmt.uniform(number)
  end
  
  def random_range(number_a, number_b, inclusive) when(inclusive) do
     number_a + :sfmt.uniform() * (number_b + 1)
  end
  
   def random_range(number_a, number_b, inclusive) when(inclusive |> Kernel.not) do
    number_a + :sfmt.uniform() * number_b
  end
  
  def sample_index(ari) do
    size = :array.size(ari)
    index = integer_random_range(0, size, false)
    index
  end

  def integer_random_range(number_a, number_b, inclusive) when(inclusive) do
    number_a + Float.floor(:sfmt.uniform() * (number_b + 1))
  end

  def integer_random_range(number_a, number_b, inclusive) when(inclusive |> Kernel.not) do
    number_a + Float.floor(:sfmt.uniform() * number_b )
  end
end 