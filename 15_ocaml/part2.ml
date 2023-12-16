#require "core";;
open Core;;


(*Convert a string to a list of chars*)
let s2cl (s: string): char list = 
  List.init (String.length s) ~f:(String.get s);;


(*Parse an operation string into the tuple (hash, opcode, lens, label).*)
let get_parts (charecters: char list): (int * char * int * string) =
  let cl2s (cl: char list) : string =
    String.concat ~sep:"" (List.map ~f:(String.make 1) cl)
  in
  let hash_step (acc: int) (c: char) : int = 
    ((acc + (Char.to_int c) ) * 17) % 256
  in
  let rec get_parts_helper (charecters: char list) (acc: int) (hs: char list): (int * char * int * string) = 
    match charecters with
    | [] -> (acc, '?', 0, "")
    | '-'::xs -> (acc, '-', 0, cl2s(hs))
    | '='::xs -> (acc, '=', (int_of_string (cl2s xs)), cl2s(hs))
    | x::xs -> get_parts_helper xs (hash_step acc x) (hs@[x])
  in
    get_parts_helper charecters 0 [];;


(*Print the table row by row for debugging.*)
let show_table ht =
  let row_to_string (l: (string*int) list): string =
    List.fold_left ~f:(fun acc (id,x) -> acc ^ "[" ^ id ^ " " ^ string_of_int x ^ "] ") ~init:"" l
  in
    Hashtbl.iteri ht ~f:(fun ~key:x ~data:y -> Printf.printf "%i -> %s\n" x (row_to_string y));;


(*Compute the final score from the table.*)
let score_table ht =
  let score_row (l: (string*int) list): int =
    List.foldi ~f:(fun i acc (_,x) -> (acc+((i+1)*x)) ) ~init:0 l
  in
  Hashtbl.fold ht ~f:(fun ~key:x ~data:y (acc:int) -> acc + (x+1) * (score_row y)) ~init:0;;


(*Hash table for lenses.*)
let table = Hashtbl.create (module Int);;


(*Run a single op on the table.*)
let do_step (h, op, l, id) = 
  let rec add_or_replace_with (a, b) (l: (string*int) list)  =
    match l with
    | [] -> [(a,b)]
    | (k,v)::xs -> 
      if String.equal k a then 
        (a,b)::xs
      else 
        (k,v)::(add_or_replace_with (a,b) xs)
  in

  let old_entry =
    Option.value (Hashtbl.find table h) ~default:[]
  in

  match op with
  | '-' -> Hashtbl.set table ~key:h ~data:(
    List.filter old_entry ~f:(fun (i,_) -> not (String.equal i id )))
  | _ -> Hashtbl.set table ~key:h ~data:( add_or_replace_with (id, l) old_entry)
;;


(*Run all ops on the table.*)
let rec do_all (ops: (int*char*int*string) list) =
  match ops with
  | [] -> ()
  | op::tail_ops ->
    let () = do_step op
    in
      do_all tail_ops
  ;;


(*Parse all ops and run them on the table.*)
let ops = In_channel.read_all "./input.txt" 
  |> String.split_on_chars ~on:[ ',' ]
  |> List.map ~f:s2cl
  |> List.map ~f:get_parts
in 
  do_all ops
;;

printf "Final score: %d\n" (score_table table);;
