defmodule MapPermutationTest do
  use ExUnit.Case

  describe "permute/2" do
    test ":ok with default cardinality is a set with the original set as its only member" do
      map = %{a: 1, b: 2, c: 3}
      assert {:ok, MapSet.new([map])} == Permutation.permute(map)
    end

    test ":ok with smaller cardinality" do
      map = %{a: 1, b: 2, c: 3}

      assert {:ok,
              MapSet.new([
                %{a: 1, b: 2},
                %{a: 1, c: 3},
                %{b: 2, c: 3}
              ])} == Permutation.permute(map, cardinality: 2)
    end

    test ":ok cardinality of one is a set with members each containing 1 element" do
      map = %{a: 1, b: 2, c: 3}

      assert {:ok,
              MapSet.new([
                %{a: 1},
                %{b: 2},
                %{c: 3}
              ])} == Permutation.permute(map, cardinality: 1)
    end
  end

  describe "permute!/2" do
    test "result on :ok" do
      map = %{a: 1, b: 2, c: 3}
      assert MapSet.new([map]) == Permutation.permute!(map)
    end

    test "raise on :error" do
      assert_raise ArgumentError, fn ->
        Permutation.permute!(%{a: 1, b: 2, c: 3}, cardinality: false)
      end
    end
  end
end
