defmodule DelegateAccess do
  @funs [fetch: 2, get: 3, get_and_update: 3, pop: 2]
  @keys Keyword.keys(@funs)

  defp delegate_access({:__aliases__, _, module_parts}) do
    delegate_access(Module.concat(module_parts))
  end
  defp delegate_access(module) do
    exports = module.__info__(:functions) |> Enum.filter(&(&1 in @funs)) |> Enum.into(%{})
    fn fun, arity ->
      case exports do
        %{^fun => ^arity} ->
          args = Macro.generate_arguments(arity, nil)
          quote do
            @impl Access
            defdelegate unquote(fun)(unquote_splicing(args)), to: unquote(module)
            defoverridable [{unquote(fun), unquote(arity)}]
          end
        _ ->
          nil
      end
    end
  end

  defmacro __using__(opts) do
    delegate = delegate_access(opts[:to])
    only = Keyword.take(opts[:only] || @funs, @keys)

    quote do
      @behaviour Access

      unquote(for {fun, arity} <- only do
        delegate.(fun, arity)
      end)
    end
  end
end
