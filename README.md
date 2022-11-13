# Permutation

[![Module Version](https://img.shields.io/hexpm/v/permutation.svg)](https://hex.pm/packages/permutation)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/permutation/)
[![Total Download](https://img.shields.io/hexpm/dt/permutation.svg)](https://hex.pm/packages/permutation)
[![License](https://img.shields.io/hexpm/l/permutation.svg)](https://hex.pm/packages/permutation)
[![Last Updated](https://img.shields.io/github/last-commit/fireproofsocks/permutation.svg)](https://github.com/fireproofsocks/permutation/commits/master)

This is an Elixir package that calculates [permutations](https://en.wikipedia.org/wiki/Permutation) of enumerables, including [combinations](https://en.wikipedia.org/wiki/Combination), where the order does not matter.

This is implemented as an Elixir Protocol, which helps communiate the difference between permutations and combinations in way that is more familiar to Elixir programmers: the permutations of a `List` are true permutations, whereas the "permutations" of a `MapSet` are *combinations* (because `MapSet`s have no inherent order).

## Examples

The output of `Permutation.permute/2` is always a `MapSet`, regardless of the type of data that is evaluated.  This is because the possible permutations are not inherently ordered. The members of the outputted `MapSet` are of the same data type as the input. E.g. the permutation result of a `List` yields a `MapSet` of `List`s. The permutation result of a `MapSet` yields a `MapSet` of `MapSet`s.

The `:cardinality` option can be specified where only a subset of the original items should be returned.

When a `MapSet` is permuted, the results are  "combinations" where the order of the items is not considered:

```iex
iex> mapset = MapSet.new([:paris, :rome, :tokyo, :budapest])
#MapSet<[:budapest, :paris, :rome, :tokyo]>
iex> Permutation.permute(mapset, cardinality: 2)
{:ok,
 #MapSet<[
   #MapSet<[:budapest, :paris]>,
   #MapSet<[:budapest, :rome]>,
   #MapSet<[:budapest, :tokyo]>,
   #MapSet<[:paris, :rome]>,
   #MapSet<[:paris, :tokyo]>,
   #MapSet<[:rome, :tokyo]>
 ]>}
```

When a `List` is permuted, this yields true permutations where the order of the items *is* considered (so there are therefore, more possibilities):

```iex
iex> list = [:paris, :rome, :tokyo, :budapest]
iex> Permutation.permute(list, cardinality: 2)
{:ok,
 #MapSet<[
   [:budapest, :paris],
   [:budapest, :rome],
   [:budapest, :tokyo],
   [:paris, :budapest],
   [:paris, :rome],
   [:paris, :tokyo],
   [:rome, :budapest],
   [:rome, :paris],
   [:rome, :tokyo],
   [:tokyo, :budapest],
   [:tokyo, :paris],
   [:tokyo, :rome]
 ]>}
```

## Installation

This package can be installed by adding `permutation` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:permutation, "~> 0.1.0"}
  ]
end
```

## See Also

This package would have taken me much longer to write if it weren't for the hard work and helpful explanations of those who went before:

- <http://www.petecorey.com/blog/2018/11/12/permutations-with-and-without-repetition-in-elixir/>
- <https://github.com/seantanly/elixir-combination>
- <https://github.com/pcorey/chord/blob/master/lib/permutation.ex>
