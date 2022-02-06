defmodule PetxTest do
  use ExUnit.Case
  doctest Petx

  test "greets the world" do
    assert Petx.hello() == :world
  end
end
