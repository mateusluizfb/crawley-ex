defmodule CrawleyTest do
  use ExUnit.Case
  doctest Crawley

  test "greets the world" do
    assert Crawley.hello() == :world
  end
end
