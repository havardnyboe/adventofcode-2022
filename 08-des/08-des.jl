# --- Day 8: Treetop Tree House ---

function get_visible_trees(forrest::Matrix{Int})
    visible_trees = (size(forrest, 2) - 2) * 2 + size(forrest, 1) * 2
    for x in 2:size(forrest, 1)-1, y in 2:size(forrest, 2)-1
        tree = forrest[x, y]

        if tree > maximum(forrest[x, y+1:end])
            visible_trees += 1
        elseif tree > maximum(forrest[x, 1:y-1])
            visible_trees += 1
        elseif tree > maximum(forrest[1:x-1, y])
            visible_trees += 1
        elseif tree > maximum(forrest[x+1:end, y])
            visible_trees += 1
        end
    end
    return visible_trees
end

mutable struct View
    top::Int
    bottom::Int
    left::Int
    right::Int
end

function get_highest_scenic_score(forrest::Matrix{Int})
    scenic_scores = zeros(Int, size(forrest))
    
    for x in 2:size(forrest, 1)-1, y in 2:size(forrest, 2)-1
        view = View(0,0,0,0)
        current_tree = forrest[x, y]
        
        for tree in reverse(forrest[1:x-1, y])
            view.top += 1
            if tree >= current_tree break end
        end
        for tree in forrest[x+1:end, y]
            view.bottom += 1
            if tree >= current_tree break end
        end
        for tree in reverse(forrest[x, 1:y-1])
            view.left += 1
            if tree >= current_tree break end
        end
        for tree in forrest[x, y+1:end]
            view.right += 1
            if tree >= current_tree break end
        end

        scenic_scores[x, y] = view.top * view.bottom * view.left * view.right
    end

    return scenic_scores |> maximum
end

function main()
    forrest = parse.(Int64, reduce(hcat, collect.(readlines("08-des.txt")))) # fant denna på webben, dot-notasjonen er psyco https://docs.julialang.org/en/v1/base/punctuation/#Punctuation
    forrest_test = [
        3 0 3 7 3; 
        2 5 5 1 2; 
        6 5 3 3 2; 
        3 3 5 4 9; 
        3 5 3 9 0;
    ]
    
    println("Part 1: ", get_visible_trees(forrest))
    println("Part 2: ", get_highest_scenic_score(forrest))
end

main()