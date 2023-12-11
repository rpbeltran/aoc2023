#!/usr/bin/env kotlin

import java.io.File
import java.io.InputStream


data class Coord(
    var x: Long,
    var y: Long,
    var x_exp: Long,
    var y_exp: Long)


// -- Parse --

val locations = mutableListOf<Coord>()
val xs = mutableListOf<Int>()
val ys = mutableListOf<Int>()

var line_num = 0
File("input.txt").inputStream().bufferedReader().forEachLine {
    for ((i,c) in it.withIndex()) {
        if (c == '#') {
            locations.add(Coord(i.toLong(), line_num.toLong(), 0L, 0L))
            xs.add(i)
            ys.add(line_num)
        }
    }
    line_num += 1
}


// -- Expand --

for (x in (xs.max() downTo 0)) {
    if (! (x in xs)) {
        locations.forEach{ if (it.x > x ) {it.x_exp += 1L} }
    }
}

for (y in (ys.max() downTo 0)) {
    if (! (y in ys)) {
        locations.forEach{ if (it.y > y ) {it.y_exp += 1L} }
    }
}


// -- Pair Up --

fun dist(a: Coord, b: Coord, expansion: Long = 1): Long {
    return (
        Math.abs(b.x - a.x + (b.x_exp - a.x_exp) * expansion) +
        Math.abs(b.y - a.y + (b.y_exp - a.y_exp) * expansion)
    )
}

var total_distance = 0L
var total_distance2 = 0L
for (a in locations) {
    for (b in locations) {
        total_distance += dist(a, b, 1L)
        total_distance2 += dist(a, b, 1000000L)
    }    
}

println(total_distance / 2)
println(total_distance2 / 2)
