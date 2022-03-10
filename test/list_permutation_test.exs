defmodule ListPermutationTest do
  use ExUnit.Case

  describe "permute/2" do
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

  describe "permute!/2" do
    test "result on :ok" do
      assert MapSet.new([
               [:a, :b, :c],
               [:a, :c, :b],
               [:b, :a, :c],
               [:b, :c, :a],
               [:c, :a, :b],
               [:c, :b, :a]
             ]) == Permutation.permute!([:a, :b, :c])
    end

    test "raise on :error" do
      assert_raise ArgumentError, fn ->
        Permutation.permute!([:a, :b, :c], cardinality: false)
      end
    end
  end
end
