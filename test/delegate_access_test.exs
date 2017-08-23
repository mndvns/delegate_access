defmodule Test.DelegateAccess do
  use ExUnit.Case
  doctest DelegateAccess

  defmodule Foo do
    defstruct [:buz, :baz]
    use DelegateAccess, to: Map
  end

  defmodule Bar do
    defstruct [:qux, :rar]
    use DelegateAccess, to: Map, only: [fetch: 2]
    use DelegateAccess, to: Keyword, only: [get: 2, get: 3]
  end

  test "Foo" do
    assert %Foo{buz: 10}[:buz] == 10
  end

  test "Bar" do
    assert %Bar{qux: %Foo{buz: 10}}[:qux][:buz] == 10
  end
end
