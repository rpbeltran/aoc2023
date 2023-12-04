# (Alphabetical) Advent of Code 2023

Advent of Code 2023 solutions with a different programming language each day, each beginning with the associated letter of the alphabet.


## Day 1: A is for Awk

``` 
 >  time awk -f part1.awk input.txt
 0.00s user 0.00s system 0.010 total
 >  time awk -f part2.awk input.txt | awk -f part1.awk
 0.02s user 0.01s system 0.022 total
```

## Day 2: B is for Bash

``` 
 >  time ./part1.sh input.txt
 0.05s user 0.07s system 0.128 total
 >  time ./part2.sh input.txt
 0.05s user 0.08s system 0.142 total
```

## Day 3: C is for C++

``` 
 >  clang++ part1.cpp -o part1 --std=c++20
 >  clang++ part2.cpp -o part2 --std=c++20
 >  time ./part1 input.txt
 0.01s user 0.00s system 0.014 total
 >  time ./part2 input.txt
 0.01s user 0.00s system 0.013 total
```

## Day 4: D is for D

``` 
 >  dmd part1.d common.d
 >  dmd part2.d common.d
 >  time ./part1
 0.01s user 0.00s system 0.024 total
 >  time ./part2
 0.02s user 0.00s system 0.025 total
```
