# waifu.exs
full_test = "xxharuhixxxasukasuka"
waifus = ["haruhi", "asuka", "tomoko"]
assert_counts = %{"haruhi" => 1, "asuka" => 2, "tomoko" => 0}

defmodule WaifuFinder do
  @spec find(binary, [binary]) :: map
  def find(str, waifus), do: find(str, waifus, %{})

  @spec find(binary, [binary], map) :: map
  def find(<<>>, _, count), do: count

  def find(<<_, rest::binary>> = str, waifus, count) do
    find(
      rest,
      waifus,
      Enum.reduce(waifus, count, fn waifu, count ->
        if str_match?(str, waifu) do
          Map.update(count, waifu, 1, &(&1 + 1))
        else
          Map.update(count, waifu, 0, & &1)
        end
      end)
    )
  end

  @spec str_match?(binary, binary) :: boolean
  def str_match?(<<a, str_rest::binary>>, <<a, waifu_rest::binary>>), do: str_match?(str_rest, waifu_rest)
  def str_match?(<<_a, _::binary>>, <<_b, _::binary>>), do: false
  def str_match?(_, <<>>), do: true
  def str_match?(<<>>, _), do: false
end

WaifuFinder.find(full_test, waifus)
|> dbg
