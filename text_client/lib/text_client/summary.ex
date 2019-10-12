defmodule TextClient.Summary do
  def display(game = %{tally: tally, game_service: %{used: used}}) do
    IO.puts([
      "\n",
      "Words so far: #{Enum.join(tally.letters, "")}\n",
      "Letters used: #{Enum.join(used, "")}\n",
      "Guessed left: #{tally.turns_left}\n"
    ])

    game
  end
end
