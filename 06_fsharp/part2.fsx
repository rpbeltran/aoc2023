open System

let get_int (line: string) = (Array.toList(line.Split([|' '|], StringSplitOptions.RemoveEmptyEntries)).Tail) |> List.fold (+) "" |> float;

let input = System.IO.File.ReadAllText("input.txt").Split [|'\n'|];

let determinant(t, d) = (sqrt((t*t)-(4.0 * (d + 0.01))));
let solve_options (t, d) = 1.0 + Math.Floor((t + determinant(t, d)) / 2.0) - Math.Ceiling((t - determinant(t, d)) / 2.0);

let races = solve_options(get_int(input[0]), get_int(input[1]))

printfn( $"{races}" )