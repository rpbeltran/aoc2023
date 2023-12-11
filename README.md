# (Alphabetical) Advent of Code 2023

Advent of Code 2023 solutions with a different programming language each day, each beginning with
the associated letter of the alphabet.
Most of these languages I was unfamiliar with before starting and so I won't vouch for having used
any of them correctly.
Also, approximately zero effort or care went into making the solutions readable, terse, etc.
The main purpose of this was just to force myself to problem solve outside of my comfort zone and
"practice learning".


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
I thought Elixir seemed like the faster learn and the one I would be most likely to use again later.
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


## Day 8: H is for Haskell

```
> ghc part1.hs
> ghc part2.hs
> time ./part1
0.03s user 0.01s system 0.249 total
> time ./part2
0.14s user 0.01s system 0.292 total
```

It's been a while since I've used Haskell but I think it's more enjoyable than any of the functional
languages I've had to use in this challenge so far.


## Day 9: I is for Idris

```
> idris2 part1.idr -o part1
> idris2 part2.idr -o part2
> time ./part1
0.03s user 0.01s system 0.045 total
> time ./part2
0.03s user 0.01s system 0.048 total
```

Idris was like Haskell, if Haskell had terrible documentation and beyond useless error messages.
Honestly hard to see why I would ever want to use this right now, but to be fair, idris is not yet
at version 1.0, and I wasn't using any of it's main selling points (therorem proofs and
verification), which actually do sound pretty cool. I ended up looking for functions I needed in the
sourcecode of their standard library because I couldn't figure out the docs.

## Day 10: J is for Julia

```
> time julia part1.jl
0.67s user 1.42s system 0.375 total
> time julia part2.jl
1.35s user 1.23s system 0.707 total
```

Possibly the first somewhat annoying problem of the year, and a very busy day makes for ugly code in
a new language. I learned basically the minimum amount necessary and wrote some really messy code in
the global namespace. This makes for a poor sample to judge Julia off of but I'll say it felt like a
clunkier Python syntax without classes and with a little bit more typing (but still dynamically
typed). I ran into some errors at first because I didn't realize Julia was 1 indexed. Docs, Stack
Overflow and error messages were all much more usable than yesterday's Idris. The tooling is nice
but as a nitpick I prefer it when languages install themselves onto a place that's already on my
path instead of inside my applications directory like Juilia chose to. At this point I'm pretty much
just owning that the code in this repository will be awful and embaressing unless I take some time
later to clean it up.
