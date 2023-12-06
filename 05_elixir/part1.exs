defmodule Part1 do

  def get_mapping(lines) do
      Enum.map((tl lines), &String.split/1)
      |> Enum.map(fn (l) -> Enum.map(l, &String.to_integer/1) end)
      |> Enum.map(&List.to_tuple/1)
  end

  def parse_and_solve(lines) do
    mappings = Enum.chunk_by(
      (tl tl lines),
      fn (l) -> l == "" end
    )
    |> Enum.map(&Part1.get_mapping/1)

    Enum.map((tl String.split(hd lines)), &String.to_integer/1)
    |> Enum.map(fn (s) -> List.foldl(mappings, s, &Part1.forward/2) end)
    |> Enum.min
  end

  def forward(mapping, seed) do
    {dst, src, _} = Enum.find(
      mapping, {seed, seed, 0},
      fn ({_, s, r}) -> (seed >= s) && (seed < s + r) end
    )
    seed + dst - src
  end

end

File.read!("input.txt")
|> String.split(~r{\n})
|> Part1.parse_and_solve
|> IO.puts
