defmodule Dictionary.Dictionary do
  def random_word(word_list) do
    word_list
    |> Enum.random()
  end
end
