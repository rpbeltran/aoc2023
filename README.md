# (Alphabetical) Advent of Code 2023

Advent of Code 2023 solutions with a different programming language each day, each beginning with the associated letter of the alphabet. Most of these languages I was unfamiliar with before starting and so I won't vouch for having used any of them correctly.


## Day 1: A is for Awk

``` 
 >  time awk -f part1.awk input.txt
 0.00s user 0.00s system 0.010 total
 >  time awk -f part2.awk input.txt | awk -f part1.awk
 0.02s user 0.01s system 0.022 total
```

I hadn't really used Awk before beyond copy-paste-modify from the internet.
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
I wouldn't mind exploring it further since I definitely didn't get in too deep for this.


## Day 6: F is for F#

```
> dotnet fsi part1.fsx
0.73s user 0.22s system 0.742 total
> dotnet fsi part2.fsx
0.70s user 0.18s system 0.702 total
```

F# was a lot like elixir but for some reason the syntax was just not as much fun.
Then again.. I learned the minimum syntax necessary so what's' my opinions even worth.
It was an easy AOC problem (I took the math approach) so not much algorithms to do here.
For a larger project, access to the .NET ecosystem could have been convenient, but for AOC I think it was just meh.


## Day 7: G is for Golang

```
> go build part1.go
> go build part2.go
> time ./part1
0.01s user 0.01s system 0.018 total
> time ./part2
0.01s user 0.01s system 0.019 total
```

The first language since Day 3 that I actually use frequently.
Golang just works and is makes life really easy, but also it's kinda boring.
