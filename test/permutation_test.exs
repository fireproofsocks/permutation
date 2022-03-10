defmodule PermutationTest do
  use ExUnit.Case

  describe "Mapset permut/2" do
    test ":ok with default cardinality is a set with the original set as its only member" do
      mapset = MapSet.new([:a, :b, :c])
      assert {:ok, MapSet.new([mapset])} == Permutation.permute(mapset)
    end

    test ":ok with smaller cardinality" do
      mapset = MapSet.new([:a, :b, :c])

      assert {:ok,
              MapSet.new([
                MapSet.new([:a, :b]),
                MapSet.new([:a, :c]),
                MapSet.new([:b, :c])
              ])} == Permutation.permute(mapset, cardinality: 2)
    end

    test ":ok cardinality of one is a set with members each containing 1 element" do
      mapset = MapSet.new([:a, :b, :c])

      assert {:ok,
              MapSet.new([
                MapSet.new([:a]),
                MapSet.new([:b]),
                MapSet.new([:c])
              ])} == Permutation.permute(mapset, cardinality: 1)
    end
  end

  describe "List permute/2" do
    test ":ok" do
      assert {:ok,
              MapSet.new([
                [:a, :b, :c],
                [:a, :c, :b],
                [:b, :a, :c],
                [:b, :c, :a],
                [:c, :a, :b],
                [:c, :b, :a]
              ])} == Permutation.permute([:a, :b, :c])
    end

    test "cardinality enforced" do
      assert {:ok, MapSet.new([[:a, :b], [:a, :c], [:b, :a], [:b, :c], [:c, :a], [:c, :b]])} ==
               Permutation.permute([:a, :b, :c], cardinality: 2)
    end

    test ":error for invalid cardinality data type" do
      assert {:error, _} = Permutation.permute([:a, :b, :c], cardinality: false)
    end

    test ":error for cardinality out of bounds" do
      assert {:error, _} = Permutation.permute([:a, :b, :c], cardinality: 4)
    end
  end
end
