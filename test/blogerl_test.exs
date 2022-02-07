defmodule BlogerlTest do
  use ExUnit.Case
  doctest Blogerl

  test "greets the world" do
    assert Blogerl.hello() == :world
  end
end
