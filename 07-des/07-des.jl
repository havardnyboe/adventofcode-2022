# --- Day 7: No Space Left On Device ---
# laget med _kraftig_ hjelp fra kjære gode internett fordi trøtt etter eksamen :(

function get_size(path, tree)
    size = 0
    for (key, val) in tree
        if startswith(key, path)
            size += sum(val)
        end
    end
    return size
end

function create_disk(input)
    disk = Dict{String, Vector{Integer}}()
    curr_dir = []
    for line in input
        if line[1] == '$'
            if line[3:4] == "cd"
                if line[6:end] == ".."
                    pop!(curr_dir)
                else
                    push!(curr_dir, line[6:end])
                    disk[abspath(curr_dir...)] = []
                end
            end
        else
            if line[1:3] != "dir"
                push!(disk[abspath(curr_dir...)], parse(Int, split(line)[1]))
            end
        end
    end
    return Dict(path => get_size(path, disk) for (path, size) in disk)
end

function main()
    disk        = create_disk(readlines("07-des.txt"))
    disk_size   = 70000000
    update_size = 30000000
    
    p1 = 0
    for (_, size) in disk
        if size <= 100000
            p1 += size
        end
    end
    println("Part 1: $p1")

    # --- Part Two ---

    free_space = disk_size - disk["/"]
    p2 = Inf
    for (_, size) in disk
        if size >= update_size - free_space && size < p2
            p2 = size
        end
    end
    println("Part 2: $p2")
    
end

main()