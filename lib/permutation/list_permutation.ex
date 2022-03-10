defimpl Permutation, for: [List] do
  @doc """
  Find all possible permutations (where order matters) of the `List`'s members, returned as
  a `MapSet` of `List`s.

  ## Options

  - `:cardinality` (integer) the maximum number of elements in each returned permutation.
  """
  def permute(list, opts \\ []) do
    case Keyword.get(opts, :cardinality, length(list)) do
      k when is_integer(k) and k >= 0 and k <= length(list) ->
        {:ok,
         list
         |> generate(k)
         |> MapSet.new()}

      _ ->
        {:error, "Invalid cardinality"}
    end
  end

  @doc """
  As with `Permutation.permute/2` but raises on error.
  """
  def permute!(map, opts \\ []) do
    case permute(map, opts) do
      {:ok, result} -> result
      {:error, error} -> raise ArgumentError, error
    end
  end

  defp generate(_list, 0), do: [[]]

  defp generate(list, k) when is_integer(k) do
    for x <- list, y <- generate(list -- [x], k - 1) do
      [x | y]
    end
  end
end
