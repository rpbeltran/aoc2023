
struct Node
    x::Int
    y::Int
    tile::Char
end


lines = readlines("input.txt")

tiles = []
start = nothing
for (y, line) in enumerate(lines)
    row = []
    for (x, c) in enumerate(line)
        node = Node(x,y,c)
        if c == 'S'
            global start = node
        end
        push!(row, node)
    end
    push!(tiles, row)
end


explored = Set()
frontier = Set([start])
distance = 0
while length(frontier) > 0
    new_frontier = Set()
    for from in frontier
        if from.tile in "S|LJ" && from.y > 1 # North
            new_tile = tiles[from.y-1][from.x]
            if from.tile != 'S' && new_tile.tile != "."
                push!(new_frontier, new_tile)
            elseif from.tile == 'S'
                if new_tile.tile in "|7F"
                    push!(new_frontier, new_tile)
                end
            end
        end
        if from.tile in "S|7F" && from.y < length(tiles) # South
            new_tile = tiles[from.y+1][from.x]
            if from.tile != 'S' && new_tile.tile != "."
                push!(new_frontier, new_tile)
            elseif from.tile == 'S'
                if new_tile.tile in "|LJ"
                    push!(new_frontier, new_tile)
                end
            end
        end
        if from.tile in "S-LF" && from.x < length(tiles[1]) # East
            new_tile = tiles[from.y][from.x+1]
            if from.tile != 'S' && new_tile.tile != "."
                push!(new_frontier, new_tile)
            elseif from.tile == 'S'
                if new_tile.tile in "-J7"
                    push!(new_frontier, new_tile)
                end
            end
        end
        if from.tile in "S-J7" && from.x > 1 # West
            new_tile = tiles[from.y][from.x-1]
            if from.tile != 'S' && new_tile.tile != "."
                push!(new_frontier, new_tile)
            elseif from.tile == 'S'
                if new_tile.tile in "-LF"
                    push!(new_frontier, new_tile)
                end
            end
        end
        push!(explored, from)
        setdiff!(new_frontier, explored)
    end
    global distance += 1
    global frontier = new_frontier
end

println(distance - 1)