defmodule Fib do
  def start do
    {:ok, pid} = Agent.start_link(fn -> %{0 => 0, 1 => 1} end)
    pid
  end

  def fib(n) do
    start()
    |> fib(n)
  end

  def fib(pid, n) do
    Agent.get(pid, fn state -> state[n] end)
    |> return_or_calculate(pid, n)
  end

  def return_or_calculate(result, _pid, _n) do
    result
  end

  def return_or_calculate(nil, pid, n) do
    calculated = fib(pid, n - 1) + fib(pid, n - 2)

    Agent.update(pid, fn state ->
      Map.put(state, n, calculated)
    end)

    calculated
  end
end
