# --- Day 6: Tuning Trouble ---

function get_proceeding_range(stream::String, offset::Int)
    for i in 1:length(stream)-offset-1
        packet_start = Set(split(SubString(stream, i, i+offset-1), ""))
        if length(packet_start) == offset
            return i + offset-1
            break
        end
    end
end

function main()
    stream = readline("06-des.txt")

    println("Part 1: ", get_proceeding_range(stream, 4))
    println("Part 2: ", get_proceeding_range(stream, 14))
    
end    

main()