defmodule GameTest do
  use ExUnit.Case
  alias Hangman.Game

  test "new_game returns stucture" do
    game = Game.new_game()
    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0

    letters =
      ?a..?z
      |> Enum.to_list()
      |> List.to_string()
      |> String.codepoints()

    game.letters
    |> Enum.map(fn l -> assert Enum.member?(letters, l) end)
  end

  test "state isnt changed for :won  or : lost game" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)

      assert {game, _tally} = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is already used" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guesss is recognized" do
    game = Game.new_game("wibble")
    {game, _tally} = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a good guessed word is a won game" do
    game = Game.new_game("wibble")

    # for letter <- String.codepoints("wibble") do
    # {game, _tally} = Game.make_move(game, letter)
    # assert game.game_state == :good_guess
    # assert game.turns_left == 7
    # end

    {game, _tally} = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7

    {game, _tally} = Game.make_move(game, "i")
    assert game.game_state == :good_guess
    assert game.turns_left == 7

    {game, _tally} = Game.make_move(game, "b")
    assert game.game_state == :good_guess
    assert game.turns_left == 7

    {game, _tally} = Game.make_move(game, "l")
    assert game.game_state == :good_guess
    assert game.turns_left == 7

    {game, _tally} = Game.make_move(game, "e")
    assert game.game_state == :won
    assert game.turns_left == 7
  end

  test "bad guess is recogniesed" do
    game = Game.new_game("wibble")
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "bad guess is lost" do
    game = Game.new_game("wibble")
    {game, _tally} = Game.make_move(game, "a")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 5
    {game, _tally} = Game.make_move(game, "c")
    {game, _tally} = Game.make_move(game, "d")
    {game, _tally} = Game.make_move(game, "y")
    {game, _tally} = Game.make_move(game, "f")
    {game, _tally} = Game.make_move(game, "g")
    assert game.game_state == :lost
    assert game.turns_left == 0
  end

  test "won game with loop" do
    moves = [
      {"w", :good_guess},
      {"i", :good_guess},
      {"b", :good_guess},
      {"l", :good_guess},
      {"e", :won}
    ]

    game = Game.new_game("wibble")

    Enum.reduce(moves, game, fn {guess, state}, new_game ->
      {new_game, _tally} = Game.make_move(new_game, guess)
      assert new_game.game_state == state
      new_game
    end)
  end
end
