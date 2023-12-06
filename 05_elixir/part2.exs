defmodule Part2 do

  def get_mapping(lines) do
    Enum.map((tl lines), &String.split/1)
    |> Enum.map(fn (l) -> Enum.map(l, &String.to_integer/1) end)
    |> Enum.map(&List.to_tuple/1)
  end

  def parse_and_solve(lines) do
    seeds = Enum.chunk_every(
      Enum.map((tl String.split((hd lines))), &String.to_integer/1), 2
    ) |> Enum.map(&List.to_tuple/1)
    mappings = Enum.chunk_by(
      (tl tl lines),
      fn (l) -> String.length(l) == 0 end
    )
    |> Enum.map(&Part2.get_mapping/1)
    solve(
      get_candidates(seeds, mappings),
      mappings)
  end

  def get_candidates(seeds, mappings) do
    Enum.flat_map(seeds, fn({s,_}) -> [s] end) ++ Enum.flat_map(
      Enum.with_index(mappings),
      fn({ms, i}) ->
        Enum.flat_map(
            Enum.flat_map(ms, fn ({d, s, r}) -> [s-1, s, s+r, s+r+1] end),
            fn (src) -> backtrack(seeds, src, mappings, i) end
        )
      end
    )
  end

  def backtrack(seeds, target, mappings, layer) do
    Enum.filter(
      [List.foldr(Enum.take(mappings, layer), target, &Part2.backward/2)],
      fn(seed) ->
        Enum.any?(seeds, fn({s,r}) -> (seed >= s) && (seed < s+r) end)
      end
    )
  end

  def solve(seeds, mappings) do
    seeds
    |> Enum.map(fn (s) -> List.foldl(mappings, s, &Part2.forward/2) end)
    |> Enum.min
  end

  def forward(mapping, seed) do
    {dst, src, _} = Enum.find(
      mapping, {seed, seed, 0},
      fn ({_, s, r}) -> (seed >= s) && (seed < s + r) end
    )
    seed + dst - src
  end

  def backward(mapping, seed) do
    {dst, src, _} = Enum.find(
      mapping, {seed, seed, 0},
      fn ({d, s, r}) -> (seed - d + s >= s) && (seed - d + s < s + r) end
    )
    seed - dst + src
  end

end

File.read!("input.txt")
|> String.split(~r{\n})
|> Part2.parse_and_solve
|> IO.puts
