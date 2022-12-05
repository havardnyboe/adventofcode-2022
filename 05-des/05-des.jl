# --- Day 5: Supply Stacks ---
# ikke den lureste måten å lære seg et nytt språk på, men men :P

function get_crates()
    crates = [[], [], [], [], [], [], [], [], []]
    for (i ,line) in enumerate(readlines("05-des.txt"))
        if i < length(crates)
            col = 1
            for j in 2:4:length(line)
                if line[j] >= Char('A')
                    pushfirst!(crates[col], Char(line[j]))
                end
                col += 1
            end
        end
    end
    return crates
end

function get_instructions()
    instructions = []
    row = 1
    for (i ,line) in enumerate(readlines("05-des.txt"))
        if i > 10
            push!(instructions, [])
            inst = split(line, " ")
            for i in 2:2:length(inst)
                push!(instructions[row], parse(Int, inst[i]))
            end
            row += 1
        end
    end
    return instructions
end

function main()

    # --- Part One ---

    crates = get_crates()
    instructions = get_instructions()

    for inst in instructions
        for i in 1:inst[1]
            tmp = pop!(crates[inst[2]])
            push!(crates[inst[3]], tmp)
        end
    end
    
    print("Part 1: ")
    for crate in crates
        if length(crate) > 0
            print(last(crate))
        end
    end
    println()

    # --- Part Two ---

    crates = get_crates()
    instructions = get_instructions()

    for inst in instructions
        arr = []
        for i in 1:inst[1]
            tmp = pop!(crates[inst[2]])
            push!(arr, tmp) 
        end
        for i in 1:inst[1]
            tmp = pop!(arr)
            push!(crates[inst[3]], tmp) 
        end
    end

    print("Part 2: ")
    for crate in crates
        if length(crate) > 0
            print(last(crate))
        end
    end
    println()

end

main()