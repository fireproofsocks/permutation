defmodule MapSetPermutationTest do
  use ExUnit.Case

  describe "MapSet permute/2" do
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

  describe "permute!/2" do
    test "result on :ok" do
      mapset = MapSet.new([:a, :b, :c])
      assert MapSet.new([mapset]) == Permutation.permute!(mapset)
    end

    test "raise on :error" do
      assert_raise ArgumentError, fn ->
        mapset = MapSet.new([:a, :b, :c])
        Permutation.permute!(mapset, cardinality: false)
      end
    end
  end
end
