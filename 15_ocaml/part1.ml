#require "core";;
open Core;;


let s2cl (s: string): char list = 
  List.init (String.length s) ~f:(String.get s);;

let get_hash (charecters: char list): int =

  let hash_step (acc: int) (c: char) : int = 
    ((acc + (Char.to_int c) ) * 17) % 256
  in

  let rec get_hash_helper (charecters: char list) (acc: int): int = 
    match charecters with
    | [] -> acc
    | x::xs ->get_hash_helper xs (hash_step acc x)
  in

  get_hash_helper charecters 0;;

let sum (l:int list): int = List.fold_left ~f:(+) ~init:0 l  ;;

let problem =
  In_channel.read_all "./input.txt" 
  |> String.split_on_chars ~on:[ ',' ]
  |> List.map ~f:s2cl in 
let total = 
  problem 
  |> List.map ~f:get_hash
  |> sum
in
  (printf "%d\n") total
;;