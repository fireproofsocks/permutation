defimpl Permutation, for: [Map] do
  @doc """
  Find all possible [combinations](https://en.wikipedia.org/wiki/Combination) of
  the `Map`'s members, returned as a `MapSet` of `Map`s.
  Because `Map`s are unordered, their permutations are also unordered.
  A "permutation" of a set that is inherently unable to be ordered is technically
  called a "combination".

  ## Options

  - `:cardinality` (integer) the maximum number of elements in each returned permutation.
  """
  def permute(map, opts \\ []) do
    n = map_size(map)

    case Keyword.get(opts, :cardinality, n) do
      k when is_integer(k) and k >= 0 and k <= n ->
        {:ok,
         map
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

  defp generate(_map, 0), do: [Map.new()]

  defp generate(map, k) when is_integer(k) do
    for {key_x, val_x} <- map, y <- generate(Map.delete(map, key_x), k - 1) do
      %{}
      |> Map.put(key_x, val_x)
      |> Map.merge(y)
    end
  end
end
