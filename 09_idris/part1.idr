module Main

import System.File.ReadWrite
import Data.String
import Data.List
import Data.Maybe

stoi : String -> Int
stoi s = case (parseInteger {a=Int} s) of
    Just i => i
    Nothing => 0

parse: String -> List (List Int)
parse content = map (\l => map stoi (words l)) $ lines content

diff: List Int -> List Int
diff line = map (\(l,r) => r-l ) (zip line $ drop 1 line)

all_zero: List Int -> Bool
all_zero [] = True
all_zero l = 
    let h = fromMaybe 0 (head' l) in
    (h == 0) && (all_zero $ drop 1 l)

all_diffs: List Int -> List (List Int)
all_diffs history =
    let d = diff history in
    if (all_zero d) then [d] else [d] ++ (all_diffs d)

my_last: List Int -> Int
my_last l = fromMaybe 0 (last' l)

get_next: List Int -> Int
get_next l = (my_last l) + (sum $ map my_last $ all_diffs l)


main : IO ()
main = do file <- readFile "input.txt"
          case file of
               Right content => printLn $ sum $ map get_next $ parse content
               Left err => printLn err
