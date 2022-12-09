# --- Day 9: Rope Bridge ---

struct Move
    dir::Char
    dist::Int
end

function Move(moves::Vector{Char})
    return Move(moves[1], parse(Int, join(moves[2:end])))
end

function get_positions(moves)
    node = [0, 0]
    positions = []

    for move in moves
        for _ in 1:move.dist
            if move.dir == 'R'
                node[1] += 1
            elseif move.dir == 'L'
                node[1] -= 1
            elseif move.dir == 'U'
                node[2] += 1
            elseif move.dir == 'D'
                node[2] -= 1
            end
            push!(positions, Tuple(node))
        end
    end
    return positions
end

function follow_node(moves)
    node = [0, 0]
    positions = []

    for move in moves
        if abs(move[1] - node[1]) > 1 || abs(move[2] - node[2]) > 1
            node[1] += (move[1] > node[1]) - (move[1] < node[1])
            node[2] += (move[2] > node[2]) - (move[2] < node[2])
        end
        push!(positions, Tuple(node))
    end
    return positions
end

function main()
    moves = Move.(deleteat!.(collect.(readlines("09-des.txt")), 2))

    ### Note to self: Husk å sjekke at du har lest input riktig. 
    ### Da slipper du å prøve å debugge i flere timer uten å skjønne hva som er feil...

    p1 = p2 = get_positions(moves)
    for _ in 1:9
        p2 = follow_node(p2)
    end
    
    println("Part 1: ", length(Set(follow_node(p1))))
    println("Part 2: ", length(Set(p2)))

end

main()
