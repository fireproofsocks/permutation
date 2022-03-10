defprotocol Permutation do
  @moduledoc """
  `Permutation` defines a protocol for calculating all possible permutations of
  a given type of data. The protocol may be implemented for any type of custom
  data which requires the calcuation of permutations (or combintations).

  ## Examples

  `MapSet`s are used when members have no inherent order:

      iex> mapset = MapSet.new([:paris, :rome, :tokyo, :budapest])
      #MapSet<[:budapest, :paris, :rome, :tokyo]>
      iex> Permutation.permute(mapset)
      {:ok, #MapSet<[#MapSet<[:budapest, :paris, :rome, :tokyo]>]>}

  `List`s are used when the members *ARE* ordered:

      iex> Permutation.permute([:a, :b, :c])
      {:ok,
      #MapSet<[
        [:a, :b, :c],
        [:a, :c, :b],
        [:b, :a, :c],
        [:b, :c, :a],
        [:c, :a, :b],
        [:c, :b, :a]
      ]>}
  """

  @doc """
  Find all possible combinations of the `collection`'s members, returned as a `MapSet`.

  ## Options

  - `:cardinality` the maximum size of the resulting subsets
  """
  def permute(enumerable, opts \\ [])

  @doc """
  As with `Permutation.permute/2` but raises on error.
  """
  def permute!(enumerable, opts \\ [])
end
