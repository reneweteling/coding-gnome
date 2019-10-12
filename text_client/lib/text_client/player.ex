defmodule TextClient.Player do
  alias TextClient.{State, Summary, Prompter, Mover}
  # won, lost, good guess, bad guess, already used, initializing
  def play(%State{tally: %{game_state: :won}}) do
    exit_with_message("You won")
  end

  def play(%State{tally: %{game_state: :lost}}) do
    exit_with_message("Sorry, better luck next time!")
  end

  def play(game = %State{tally: %{game_state: :good_guess}}) do
    continue(game, "Good guess!")
  end

  def play(game = %State{tally: %{game_state: :bad_guess}}) do
    continue(game, "Sorry, that isnt in the word")
  end

  def play(game = %State{tally: %{game_state: :already_used}}) do
    continue(game, "Youve alreaddy used that workd")
  end

  def play(game) do
    continue(game)
  end

  defp continue(game, message) do
    IO.puts(message)
    continue(game)
  end

  defp continue(game) do
    game
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play
  end

  defp exit_with_message(msg) do
    IO.puts(msg)
    exit(:normal)
  end
end
