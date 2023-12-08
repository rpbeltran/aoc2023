import Data.Maybe
import qualified Data.Map as Map
import qualified Data.List.Split as Split

parse_mapping_line line = 
    (from, (left, right))
    where
        (from:rhs:_) = Split.splitOn " = " line
        ((_:left):(right2):_) = Split.splitOn ", " rhs
        right = init right2

parse_and_do (instructions : _ : map_lines) = 
    get_steps mapping "AAA" instructions 0
    where mapping = Map.fromList $ map parse_mapping_line map_lines

get_steps mapping "ZZZ" instructions i = i
get_steps mapping start instructions i = 
    get_steps mapping next instructions (i + 1)
    where next = do_step mapping start instructions i

do_step mapping from instructions i =
    if (instruction == 'L') then left else right
    where
        (left, right) = fromJust $ Map.lookup from mapping
        instruction = instructions !! (fromEnum (mod i (length instructions)))

main :: IO ()
main = do
    contents <- readFile "input.txt"
    let result = parse_and_do $ lines contents
    print result
