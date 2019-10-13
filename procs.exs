defmodule Procs do
  def greeter(count) do
    receive do
      {:boom, reason} ->
        exit(reason)

      {:reset} ->
        greeter(0)

      {:add, amount} ->
        greeter(count + amount)

      msg ->
        IO.puts("#{count} #{msg}")
        greeter(count)
    end
  end
end
