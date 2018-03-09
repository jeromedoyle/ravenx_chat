defmodule RavenxChatTest do
  use ExUnit.Case
  doctest RavenxChat

  test "greets the world" do
    assert RavenxChat.hello() == :world
  end
end
