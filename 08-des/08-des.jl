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
        
        for tree in forrest[x, y+1:end]
            if current_tree > tree
                view.bottom +=1
            end
        end
        for tree in reverse(forrest[x, y-1:end])
            if current_tree > tree
                view.top +=1
            end
        end
        for tree in forrest[x+1:end, y]
            if current_tree > tree
                view.right +=1
            end
        end
        for tree in reverse(forrest[x-1:end, y])
            if current_tree > tree
                view.left +=1
            end
        end

        println(view)

        scenic_scores[x, y] = view.top * view.bottom * view.left * view.right
        # if tree > maximum(forrest[x, y+1:end])
        #     visible_trees += 1
        # elseif tree > maximum(forrest[x, 1:y-1])
        #     visible_trees += 1
        # elseif tree > maximum(forrest[1:x-1, y])
        #     visible_trees += 1
        # elseif tree > maximum(forrest[x+1:end, y])
        #     visible_trees += 1
        # end
            

    end

    return scenic_scores
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
    
    println("Part 1: ", get_visible_trees(forrest_test))
    println("Part 2: ", get_highest_scenic_score(forrest_test))

    # a = b = 0
    # lrtd = 0
    # for x in axes(forrest, 1), y in axes(forrest, 2)
    #     val = forrest[x, y]
    #     lrtd = [forrest[x-1:-1:1, y:y], forrest[x+1:end, y:y], forrest[x:x, y-1:-1:1], forrest[x:x, y+1:end]]
    #     a += any(val .> maximum.(lrtd, init=-1)) ? 1 : 0
    #     b = max(b, prod([something(findfirst(i -> i >= val, vec(j)), length(j)) for j in lrtd]))
    # end

    # @show(a, b)
end

main()