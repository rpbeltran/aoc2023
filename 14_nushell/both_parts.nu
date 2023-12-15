
# Search sorted values for the first whose value greater than the target but less than infinity
# If none exists in values, <infinity> is returned
def binary_search [values: list<int>, target: int, infinity: int] -> int {
    mut a = 0
    mut b = ($values | length) - 1
    loop {
        if $a > $b {
            break
        }
        let c = ($a + $b) // 2;
        let v = $values | get $c
        if $v < $target {
            $a = $c + 1
        } else if $v > $target {
            $b = $c - 1
        } else {
            break
        }
    }
    let m = (($a + $b) // 2 ) + 1
    if $m >= ($values | length) {
        return $infinity
    } else  {
        return ($values | get $m)
    }
}

# Roll a sorted list of rock positions into the furthest places possible
def roll [rocks: list<int>, pillars: list<int>, width: int ] -> list<int> {
    let reversed = $rocks | reverse
    let count = $reversed | length

    mut new_rocks = []
    mut previous = ($width + 1)
    
    mut $i = 0
    loop {
        if $i >= $count {break}
        let $rock = $reversed | get $i
        let pillar_after = binary_search $pillars $rock $previous

        $previous = (([$previous, $pillar_after] | math min) - 1)
        $new_rocks = ($new_rocks | append $previous)
        $i = $i + 1
    }
    return $new_rocks
}

# Roll stones left to right
def roll_right [rocks: list<list<int>>, pillars: list<list<int>>, width: int] -> list<list<int>> {
    $rocks | zip $pillars | each { |i|
        roll $i.0 $i.1 $width
    }
}

# Get indexes for each instance of a char in the problem
def parse_for [problem: list<list<string>>, item: string] -> list<list<int>> {
    let w = ($problem | get 0 | length) - 1
    $problem | each { |row|
        (0..$w) | filter { |i|
            ($row | get $i) == $item
        }
    }
}

def build_image [stones: list<list<int>>, pillars: list<list<int>>, w: int] {
     (0..$w) | each { |r|
        (0..$w) | each {|c|
            if $c in ($stones | get $r) {
                "O"
            } else if $c in ($pillars | get $r) {
                "#"
            } else {
                "."
            }
        } | str join
    } | str join "\n"
}

# Display a 2d list
def show [problem: list<list<string>>] {
    $problem | each { |row|
        print ($row  | str join ' ')
    }
    print ""
}

# Get input as a list of lists
def get_problem [] -> list<list<string>> {
    open input.txt | lines | split chars
}

# Transpose a list
def list_transpose [places : list<list<int>>, w: int] -> list<list<int>> {
    mut rows = (0..$w) | each {|| []}

    mut $col = 0
    loop { if $col > $w {break}
        let entries = ($places | get $col | length)
        mut $i = 0
        loop { if $i >= $entries {break}
            let r = ($places | get $col | get $i)
            let old_row = ($rows | get $r)
            let new_row = ($old_row | append $col)
            $rows = ($rows | update $r $new_row)
            $i = $i + 1
        }
        $col = $col + 1
    }

    return $rows
}

# Rotate a list counterclockwise
def counterclockwise [places : list<list<int>>, w: int] -> list<list<int>> {
    mut rows = (0..$w) | each {|| []}

    mut $orow = 0
    loop { if $orow > $w {break}
        let entries = ($places | get $orow | length)
        mut $i = 0
        loop { if $i >= $entries {break}
            let ocol = ($places | get $orow | get $i)
            let nrow = $w - $ocol
            let ncol = $orow
            let old_row = ($rows | get $nrow)
            let new_row = ($old_row | append $ncol)
            $rows = ($rows | update $nrow $new_row)
            $i = $i + 1
        }
        $orow = $orow + 1
    }

    return $rows
}

# Rotate a list clockwise
def clockwise [places : list<list<int>>, w: int] -> list<list<int>> {
    mut rows = (0..$w) | each {|| []}

    mut $orow = 0
    loop { if $orow > $w {break}
        let entries = ($places | get $orow | length)
        mut $i = 0
        loop { if $i >= $entries {break}
            let ocol = ($places | get $orow | get $i)
            let nrow = $ocol
            let ncol = $w - $orow
            let old_row = ($rows | get $nrow)
            let new_row = ($old_row | insert 0 $ncol)
            $rows = ($rows | update $nrow $new_row)
            $i = $i + 1
        }
        $orow = $orow + 1
    }

    return $rows
}

# Calculate a score
def score [stones: list<list<int>>, w: int] -> int {
    (0..$w) | each {|r|
        ($w - $r + 1) * ($stones | get $r | length)
    } | math sum
}

# Run the stones through a cycle
def cycle [
    stones: list<list<int>>,
    pillars1: list<list<int>>,
    pillars2: list<list<int>>,
    pillars3: list<list<int>>,
    pillars4: list<list<int>>,
    w: int] -> list<list<int>> {
    mut new_stones = $stones
    $new_stones = (roll_right $new_stones $pillars1 $w) # Roll North
    $new_stones = (clockwise $new_stones $w) # Roll West
    $new_stones = (roll_right $new_stones $pillars2 $w)
    $new_stones = (clockwise $new_stones $w) # Roll South
    $new_stones = (roll_right $new_stones $pillars3 $w)
    $new_stones = (clockwise $new_stones $w) # Roll East
    $new_stones = (roll_right $new_stones $pillars4 $w)
    $new_stones = (clockwise $new_stones $w) # Face North
    return $new_stones
}

# MD5 hash the state of all stones
def hash_stones [stones: list<list<int>>] -> string {
    $stones | each {|row| $row | str join "," } | str join ";" | hash md5
}

let problem = get_problem
let width = ($problem | length) - 1

mut stones = parse_for $problem "O"
mut pillars = parse_for $problem "#"

$stones = (clockwise $stones $width)

let pillars1 = (clockwise $pillars $width)
let pillars2 = (clockwise $pillars1 $width)
let pillars3 = (clockwise $pillars2 $width)

print "Part 1:"
print "Score:" (score (counterclockwise (roll_right $stones $pillars1 $width) $width) $width)

print "---- Part 2 -----"
mut htable = {}
mut scoretable = {}

mut cycles_complete = 0
loop {
    
    let current_hash = hash_stones $stones
    print $cycles_complete
    if $current_hash in ($htable | columns) {
        let cycle_start = ($htable | get $current_hash)
        let cycles = ($cycles_complete - $cycle_start)
        let answer_i = ($cycle_start + ( (1000000000 - $cycle_start) mod $cycles))
        print  "Cycles every"
        print  $cycles
        print "Starting at"
        print  $cycle_start
        print "Score is at"
        print  $answer_i
        print  "score is"
        print ($scoretable | get $answer_i)
        break
    }

    $htable = ($htable | insert $current_hash $cycles_complete )
    let current_score = (score (counterclockwise $stones $width) $width)

    $scoretable = ($scoretable | insert $cycles_complete $current_score )
    $stones = (cycle $stones $pillars1 $pillars2 $pillars3 $pillars $width)
    $cycles_complete = $cycles_complete + 1
}

rm htable.txt
$htable | to json | save htable.txt
rm stable.txt
$scoretable| to json | save stable.txt


$stones = (counterclockwise $stones $width)
#show (build_image $stones $pillars $width)