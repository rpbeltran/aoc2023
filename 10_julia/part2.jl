
struct Node
    x::Int
    y::Int
    tile::Char
end


lines = readlines("input.txt")


# Transform image
new_lines = []
for (y, line) in enumerate(lines)
    new_line = []
    next_line = []
    for (x, c) in enumerate(line)
        if c in "-FL" || (c == 'S' && line[x+1] in "-7J")
            push!(new_line, c, '~')
        else
            push!(new_line, c, '*')
        end
        if c in "|7F" || (c == 'S' && lines[y+1][x] in "-7J")
            push!(next_line, ':', '*')
        else
            push!(next_line, '*', '*')
        end
    end
    push!(new_lines, new_line, next_line)
    #println(join(new_line))
    #println(join(next_line))
end


# Parse new image
tiles = []
unexplored = Set()
start = nothing
for (y, line) in enumerate(new_lines)
    row = []
    for (x, c) in enumerate(line)
        node = Node(x,y,c)
        push!(unexplored, node)
        if c == 'S'
            global start = node
        end
        push!(row, node)
    end
    push!(tiles, row)
end


# Look for main loop
main_loop = Set()
frontier = Set([start])
while length(frontier) > 0
    new_frontier = Set()
    for from in frontier
        if from.tile in "S|LJ:" && from.y > 1 # North
            new_tile = tiles[from.y-1][from.x]
            if from.tile != 'S' && new_tile.tile != "."
                push!(new_frontier, new_tile)
            elseif from.tile == 'S'
                if new_tile.tile in "|7F"
                    push!(new_frontier, new_tile)
                end
            end
        end
        if from.tile in "S|7F:" && from.y < length(tiles) # South
            new_tile = tiles[from.y+1][from.x]
            if from.tile != 'S' && new_tile.tile != "."
                push!(new_frontier, new_tile)
            elseif from.tile == 'S'
                if new_tile.tile in "|LJ:"
                    push!(new_frontier, new_tile)
                end
            end
        end
        if from.tile in "S-LF~" && from.x < length(tiles[1]) # East
            new_tile = tiles[from.y][from.x+1]
            if from.tile != 'S' && new_tile.tile != "."
                push!(new_frontier, new_tile)
            elseif from.tile == 'S'
                if new_tile.tile in "-J7~"
                    push!(new_frontier, new_tile)
                end
            end
        end
        if from.tile in "S-J7~" && from.x > 1 # West
            new_tile = tiles[from.y][from.x-1]
            if from.tile != 'S' && new_tile.tile != "."
                push!(new_frontier, new_tile)
            elseif from.tile == 'S'
                if new_tile.tile in "-LF~"
                    push!(new_frontier, new_tile)
                end
            end
        end
        push!(main_loop, from)
        setdiff!(new_frontier, main_loop)
    end
    global frontier = new_frontier
end


setdiff!(unexplored, main_loop)

# Look for inside/outside points
frontier = Set()
outside = false
inside_total = 0
while length(unexplored) > 0
    start2 = pop!(unexplored)
    neighborhood = Set([start2])
    global outside = false
    global frontier = Set([start2])
    while length(frontier) > 0
        new_frontier = Set()
        for head in frontier
            for dy in [-1, 0, 1]
                y2 = head.y + dy
                if y2 > 0 && y2 <= length(tiles)
                    for dx in [-1, 0, 1]
                        x2 = head.x + dx
                        if x2 > 0 && x2 <= length(tiles[1])
                            push!(new_frontier, tiles[y2][x2])
                        else
                            global outside = true
                        end
                    end
                else
                    global outside = true
                end
            end
        end
        intersect!(new_frontier, unexplored)
        union!(neighborhood, new_frontier)
        setdiff!(unexplored, new_frontier)
        global frontier = new_frontier
    end
    if !outside
        for n in neighborhood
            if !(n.tile in "*~:")
                global inside_total += 1
            end
        end
    end
end

println(inside_total)