defmodule Randomise do
  # @on_load :reseed_generator 

  # def reseed_generator do 
  #   :sfmt.seed(:os.timestamp()) 
  # end 

  def integer_random(number) do
    #:sfmt.seed(:os.timestamp()) 
    :sfmt.uniform(number)
  end 
end 