defmodule TestFunctions do
   def fit_func_aux(genes, index, lim, acc) when index == lim do
    acc + genes[index]
  end

  def fit_func_aux(genes, index, lim, acc) when index < lim do
    fit_func_aux genes, index + 1, lim, acc + genes[index]
  end

  def test_fit_function(x, n) do
    fit_func_aux x, 0, n - 1, 0
  end
end