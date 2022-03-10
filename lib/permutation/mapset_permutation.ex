defimpl Permutation, for: [MapSet] do
  @doc """
  Find all possible [combinations](https://en.wikipedia.org/wiki/Combination) of
  the `MapSet`'s members, returned as a `MapSet` of `MapSet`s.
  Because `MapSet`s are unordered, their permutations are also unordered.
  A "permutation" of a set that is inherently unable to be ordered is technically
  called a "combination".

  ## Options

  - `:cardinality` (integer) the maximum number of elements in each returned permutation.
  """
  def permute(mapset, opts \\ []) do
    n = MapSet.size(mapset)

    case Keyword.get(opts, :cardinality, n) do
      k when is_integer(k) and k >= 0 and k <= n ->
        {:ok,
         mapset
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

  defp generate(_mapset, 0), do: [MapSet.new()]

  defp generate(mapset, k) when is_integer(k) do
    for x <- mapset, y <- generate(MapSet.delete(mapset, x), k - 1) do
      [x]
      |> MapSet.new()
      |> MapSet.union(y)
    end
  end
end
