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


## Day 11: K is for Kotlin

```
> time > ./both_parts.main.kts 
13.91s user 1.77s system 8.673 total
```

I'd used Kotlin once prior to this during an interview, so this was my second time scrambing to pick up an inkling of its syntax.
Luckily, then as now, Kotlin is about as natural as languages come, and if it weren't for my general preference to not be tied to things like the JVM (as with .NET) I would have almost certainly pursued the language further.
I like Kotlin a lot for how little I know about it.
The syntax is almost perfect, though in my opinion too many parenthesis are required at times.
If you don't mind working with the JVM, Kotlin seems pretty hard to complain about.


## Day 12: L is for Lua

```
> ./both_parts.main.kts 
30580.85s user 49.30s system 17:51:08.89 total
```

Lua is deceptively simple for how difficult it was to actually use. I had zero concerns going into
Lua but I should have had a couple. 1-indexing, undefined variables defaulting to nil, variables in
functions overwriting versions of themselves in other scopes unless local is set, and other quirks
that reminded me more of Bash than of any sane language all lead to some very annoying times
debugging. A lack of builtins for things like collecting generators to lists, adding lists, shallow
copying, etc. lead to long and boring code as well. Obviously Lua is a simple language and it would
have been harder to solve today's DP algorithm in a language like Lisp (my other L option), but for
a language I used to think of as "Python but easier to embed" I found it to be pretty annoying. I
may fix my solution later because part 2 runs slow (like, 18 hours slow...) so either my DP
algorithm isn't as good as I thought it was or my constants are just terrible. Either way my
constants are definitely terrible.


## Day 13: M is for Mojo 🔥

```
> time mojo part1.🔥 
0.10s user 0.01s system 0.107 total
> time mojo part2.🔥
0.53s user 0.15s system 0.377 total
```

It's impressive that Mojo 🔥 is as usable as it is given how early in development it is. I have
wanted to check it out since I saw Chris Lattner present it at the keynote of an LLVM Conference.
This is still a very early stage work-in-progress implementation of the language, but it had enough 
implemented to solve today's problem. The experience was a bit frustrating, but not because of any
poor design decisions or anything else I can really be upset with, it's just that a lot is missing
still. Most builtins I reached for did not exist. Adding lists? Nope! Hashmaps? I don't think so.
Directly iterating over collections? Not possible yet. But most of these errors had names like
"TODO: xyz does not exist yet". So these features are coming everntually they just aren't here yet.
Documentation was a bit difficult, and don't expect a community of stack overflow anwers to lean in
on, but I'm sure those things will come later. Was using it frustrating? Yes. Do I blame anyone for
that? No. Check back next year (or maybe the year after that) and it will probably be a much
smoother choice than it is today.


## Day 14: N is for Nushell

```
> nu both_parts.nu
6801.13s user 563.68s system 3:38:19.33 total
```

I've played with nushell in the past in terminall, but never really taken the time to learn it or to
write actual scripts in it. I have a lot of oppinions on shell languages since I've been designing
one of my own (maybe next year it will be AOC ready, but currently it's not). Shell languages should
serve two goals:

1) maximize productivity in terminal via terse and obvious syntax
2) Be generally maintainable when used as a scripting language

Bash fails on both accounts, actually. How many people recall all the syntax for even basic things
well enough to avoid going to Stack Overflow every time they want to send standard error to one file
and stdout to another? And who wants to maintain a large and growing shell script and trust's that
they won't make mistakes. Nushell improves on both aspects of this I believe but I don't think it's
perfect either (hence I think there's room for yet another).

Nushell's syntax is relatively aesthetic, though fould benefit from better for loops and from better
parsing rules for assignment, we currently need parenthesis around the RHS for pipelines or else
we get weird errors. Errors in general actually are probably the low point of the language right now
(which to be fair is not yet at version 1.0). If you misspell a variable name on one line (or forget
the `$`) you are likely to get an error on a completely different line that seems rather unrelated
so often you know that you did something wrong but aren't quite suire what it was.

Immutability and functional programming is dominant in Nushell. Mutable variables are allowed, but
most builtins are not designed to modify in place and mutable variables cannot be borrowed inside
`each` loops so imperative programming in nushell is ugly. This is an interesting choice for a shell
language, but I think this lead to some slower performance on today's algorithm, and I doubt it's as
optimized as Haskell which avoids cloning most structures even when it would appear to be doing just
that.


## Day 15: O is for Ocaml

```
> time utop part1.ml
0.34s user 0.03s system 0.371 total
> time utop part2.ml
0.38s user 0.03s system 0.411 total
```

First time using Ocaml was confusing at first because there seem to be several commonly used
standard libraries. I was using the Core Standard Library from Jane Street. I picked it because a
Google Search made that seem like the thing to do, but it seems to have broken compatibility between
my code and most of the Ocaml on Stack Overflow. The annpyance from this got significantly less
severe however once I figured out a little bit of the language basics and found the [documentation
of Core](https://ocaml.janestreet.com/ocaml-core/109.55.00/tmp/core_kernel) which was very useful
and made figuring things out from there pretty easy. Occaml is like Haskell with side effects which
made for a relatively easy learning curve.


## Day 16: P is for Python

```
>  time python3 both_parts.py
2.00s user 0.03s system 2.029 total
>  time python3 opttimized.py
1.60s user 0.01s system 1.612 total
```

Maybe Python was a lame choice and I should have picked a harder language but honestly I didn't mind
the relaxed day, especially ahead of Q. It's nice feeling comfortable again. I also added an
optimized version by avoiding any hashing calls.


## Day 17: Q is for QBasic

```
>  qb64 -x part1.bas -o $(pwd)/part1
>  qb64 -x part2.bas -o $(pwd)/part2
> time ./part1
13.39s user 0.48s system 13.796 total
> time ./part2
41.78s user 1.26s system 41.397 total
```

Terrible fun. QBasic is pretty basic so I had to build a lot from scratch. (Q)Basically you get
arrays, and that's it. When you run the code it doesn't just print to the terminal like a normy but
instead pulls up the retro GUI that looks like an old DOS terminal and then crashes mysteriously.
Debugging is pretty terrible without stack traces and I couldn't figure out
how to see more than about the last 20 lines of output at once on the little GUI so it's hard to get
it to show you its steps.

I implemented priority queues using fixed sized arrays. I had about 200 lines of code
before I even started working on Dijikstra's. This took me longer than the other days so far and
now I'm a day behind. I
think being a programmer back in the day when Basic was modern kinda sounds like fun.
More fun then any modern imperative programming language at least, but not as much fun as Prolog.
It made me wish that libraries and standard libraries didn't exist and that I had to instead build
out my own collection of little algorithms. Talk to you friend like "You got a min_heap I can use?"
and be told "Yeah, I'll get you a floppy with that". That would have been great.
When I realized I was 80% done with this one I was only as far as a python programmer would have
been after typing `import heapq`. Glad to be done with a letter I was dreading. 

Meta Note: I might go rogue tomorrow and do day 19 before day 18 so that I can do day 18 on a plane.
This challenge tends to require a lot of spam googling things like "how to split a string in ..."
which is hard to do while flying but hopefully I should be able write Rust without much docs hence
I'm holding onto the letter R.


## Day 18: R is for Rust

Rust is good. Time is low.

```
> cargo build
> time ./target/release/both_parts  
0.01s user 0.00s system 0.174 total
```


## Day 19: S is for Scala

I went with Scala instead of Swift at the last minute.
I took a weird route here and decided to write a Scala program to generate a scala program from the
imput and then run that program to get the answer. This approach was not a particuarly helpful start
for day 2. Oh well. I didn't have time to do them on the same day but I'll return to this one soon.

```
> scalac part1.scala && scala Part1    
> scalac generated_1.scala && scala generated_1
```