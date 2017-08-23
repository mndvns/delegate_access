# DelegateAccess

Delegates `Access` callbacks to other modules.

It's a small macro, but handy if your codebase is filled with structs.

## Usage

```elixir
defmodule MyModule do
  defstruct [:foo, :bar]

  use DelegateAccess, to: Map
end
```

is sugar for

```elixir
defmodule MyModule do
  defstruct [:foo, :bar]

  @behaviour Access

  defdelegate fetch(conf, key), to: Map
  defdelegate get(conf, key), to: Map
  defdelegate get(conf, key, default), to: Map
  defdelegate get_and_update(conf, key, fun), to: Map
  defdelegate pop(conf, key), to: Map
  defdelegate pop(conf, key, default), to: Map

  defoverridable [
    fetch: 2,
    get: 2,
    get: 3,
    get_and_update: 3,
    pop: 2,
    pop: 3,
  ]
end
```

You can also mix and match.

```elixir
defmodule MyModule do
  defstruct [:foo, :bar]

  use DelegateAccess, to: Map, only: [fetch: 2]
  use DelegateAccess, to: Keyword, only: [get: 2, get: 3]
end
```

## Installation

```elixir
def deps do
  [
    {:delegate_access, "~> 0.1.0"}
  ]
end
```
