open System

let get_ints (line: string) = (Array.toList(line.Split([|' '|], StringSplitOptions.RemoveEmptyEntries)).Tail) |> List.map(float);

let input = System.IO.File.ReadAllText("input.txt").Split [|'\n'|];

let determinant(t, d) = (sqrt((t*t)-(4.0 * (d + 0.01))));
let solve_options ((t, d)) = 1.0 + Math.Floor((t + determinant(t, d)) / 2.0) - Math.Ceiling((t - determinant(t, d)) / 2.0);

let races = List.zip (get_ints(input[0])) (get_ints(input[1])) |> List.map(solve_options) |> List.fold (*) 1.0;

printfn( $"{races}" )