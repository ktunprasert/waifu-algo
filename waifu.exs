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
        wf_len = String.length(waifu)

        if match?(<<^waifu::binary-size(wf_len), _::binary>>, str) do
          Map.update(count, waifu, 1, &(&1 + 1))
        else
          Map.update(count, waifu, 0, & &1)
        end
      end)
    )
  end
end

WaifuFinder.find(full_test, waifus)
|> dbg
