defmodule Sequence do
  def reverse({a, b}) do
    {b, a}
  end

  def samesame(a, a), do: true
  def samesame(_, _), do: false
  
  
end

# Write a function that takes a two-element tuple as a parameter, and uses pattern matching to return a two element tuple with the values swapped (so pass it {2,5} and you’ll get {5,2} back).

# Write a function that takes two parameters. It should return true if the parameters are the same, false otherwise. You aren’t allowed to use any conditional logic, so you’ll have to rely on pattern matching.
