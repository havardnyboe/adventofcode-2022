# --- Day 13: Distress Signal ---

Base.isless(l::Vector, r::Int) = l < [r]
Base.isless(l::Int, r::Vector) = [l] < r
Base.isless(l::Vector, r::Vector) = !isempty(r) && (isempty(l) || l[1] < r[1] || (!(r[1] < l[1]) && l[2:end] < r[2:end]))

function main()
    packets = eval.(Meta.parse.(filter(x -> x != "", readlines("13-des.txt"))))

    p1 = sum(findall(packets[1:2:end].<packets[2:2:end]))
    p2 = prod(findall(x -> x == [[2]] || x == [[6]], sort!(push!(packets, [[2]], [[6]]))))

    println("Part 1: $(p1)\nPart 2: $(p2)")

end

main()