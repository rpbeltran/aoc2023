# (Alphabetical) Advent of Code 2023

Advent of Code 2023 solutions with a different programming language each day, each beginning with the associated letter of the alphabet. Most of these languages I was unfamiliar with before starting and so I won't vouch for having used any of them correctly.


## Day 1: A is for Awk

``` 
 >  time awk -f part1.awk input.txt
 0.00s user 0.00s system 0.010 total
 >  time awk -f part2.awk input.txt | awk -f part1.awk
 0.02s user 0.01s system 0.022 total
```

Prior to Day 1 I hadn't used Awk beyond copy-paste-modify from the internet.
It's a simple language designed for parsing data which made it a good fit for early AOC problems.
I'll probably start reaching for it more frequently after this.


## Day 2: B is for Bash

``` 
 >  time ./part1.sh input.txt
 0.05s user 0.07s system 0.128 total
 >  time ./part2.sh input.txt
 0.05s user 0.08s system 0.142 total
```

Bash is always easy enough for a quick script but there really is an opening for a better designed shell language with more predictable syntax.

## Day 3: C is for C++

``` 
 >  clang++ part1.cpp -o part1 --std=c++20
 >  clang++ part2.cpp -o part2 --std=c++20
 >  time ./part1 input.txt
 0.01s user 0.00s system 0.014 total
 >  time ./part2 input.txt
 0.01s user 0.00s system 0.013 total
```

C++ is C++.

## Day 4: D is for D

```
 >  dmd part1.d common.d
 >  dmd part2.d common.d
 >  time ./part1
 0.01s user 0.00s system 0.024 total
 >  time ./part2
 0.02s user 0.00s system 0.025 total
```

First time using D and I think I would be happy to revisit it more in the future.
Very succinct and easy to use with a fun syntax.

## Day 5: E is for Elixir

```
> time elixir part1.exs
0.31s user 0.39s system 0.330 total
> time elixir part2.exs
0.32s user 0.39s system 0.345 total
```

The decision was between Elm, Erlang and Elixir since "ECMAScript" felt like a cheat.
I thought Elixir seemed like the faster learn and the one I would be most pick up again later.
It felt like a wordier Haskell.
Probably easier to use but maybe a bit less fun.
I wouldn't mind exploring it further since I definitely didn't spend a lot of time going deep into
for this one.



