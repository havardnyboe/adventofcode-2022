# --- Day 12: Hill Climbing Algorithm ---
#     du och jäg Dijkstra, og och jäg

using Graphs # https://juliagraphs.org/Graphs.jl/dev/algorithms/shortestpaths/

function get_neighbors(pos::CartesianIndex, heightmap::Matrix{Int64})
    indices = [(1, 0), (-1, 0), (0, 1), (0, -1)]
    valid = map(i -> pos + CartesianIndex(i), indices)
    filter(n -> checkbounds(Bool, heightmap, n), valid)
end

function create_hill_graph(heightmap::Matrix{Int64})
    graph = SimpleDiGraph(length(heightmap))

    for (i, h) in enumerate(heightmap)
        pos = CartesianIndices(heightmap)[i]

        for n in get_neighbors(pos, heightmap)
            if heightmap[n] <= h+1
                add_edge!(graph, i, LinearIndices(heightmap)[n])
            end
        end
    end
    graph
end

function main()
    heightmap = reduce(hcat, collect.(readlines("12-des.txt")))
    start = findfirst(x -> x == 'S', heightmap)
    dest = findfirst(x -> x == 'E', heightmap)
    heightmap[start], heightmap[dest] = 'a', 'z'
    heightmap = map(c -> c - 'a', heightmap)

    hill_graph = create_hill_graph(heightmap)
    starting_points = findall(x -> x == 0, heightmap)

    p1 = dijkstra_shortest_paths(hill_graph, LinearIndices(heightmap)[start])
    p2 = dijkstra_shortest_paths(hill_graph, map(p -> LinearIndices(heightmap)[p], starting_points))
    println("Part 1: ", p1.dists[LinearIndices(heightmap)[dest]])
    println("Part 1: ", p2.dists[LinearIndices(heightmap)[dest]])
end

main()