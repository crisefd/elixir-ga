defmodule Randomise do

  @moduledoc """
    Wrapper module for the SFMT pseudo random generator
  """

  @on_load :reseed_generator

  @spec integer_random(Integer) :: Integer

  @spec random_range(Float, Float, Boolean) :: Float

  @spec integer_random_range(Integer, Integer, Boolean) :: Integer

  @doc """
        Reseeds the SFMT when the module is loaded
       """
  def reseed_generator do 
    :sfmt.seed :os.timestamp
    :ok
  end 

  @doc """
        Generates integer random numbers
       """
  def integer_random(number) do
    reseed_generator
    round :sfmt.uniform number
  end

  @doc """
        Generates random numbers between the specified range
       """
  def random_range(number_a, number_b, inclusive \\ true) do
    if number_a >= number_b do
      raise "#random_range #{number_a} can't be minor or equal than #{number_b}"
    end
    reseed_generator
    r = case inclusive do
          :true -> number_a + :sfmt.uniform * (number_b + 1)
          :false -> number_a + :sfmt.uniform * number_b
        end
    r
  end

  @doc """
        Generates integer random numbers between the specified range
      """
  def integer_random_range(number_a, number_b, inclusive \\ true) do
    if number_a >= number_b do
      raise "#random_range #{number_a} can't be minor or equal than #{number_b}"
    end
    reseed_generator
    r = case inclusive do
          :true -> round(number_a + Float.floor(:sfmt.uniform * (number_b + 1))) 
          :false -> round(number_a + Float.floor(:sfmt.uniform * number_b ))
        end
    r
  end

end 