# mega brain kode jeg fant på webben, må skjønne hvordan denne funker en dag...

function main()
    forrest = parse.(Int64, reduce(hcat, collect.(readlines("08-des.txt"))))
    # forrest = [
    #     3 0 3 7 3; 
    #     2 5 5 1 2; 
    #     6 5 3 3 2; 
    #     3 3 5 4 9; 
    #     3 5 3 9 0;
    # ]

    p1 = p2 = 0
    for x in axes(forrest, 1), y in axes(forrest, 2)
        tree = forrest[x, y] # current tree
        lrtd = [forrest[x-1:-1:1, y:y], forrest[x+1:end, y:y], forrest[x:x, y-1:-1:1], forrest[x:x, y+1:end]] # heatmap av visibility??
        p1 += any(tree .> maximum.(lrtd, init=-1)) ? 1 : 0 # finner max visibility med fancy Julia dot-notation
        p2 = max(p2, prod([something(findfirst(i -> i >= tree, vec(j)), length(j)) for j in lrtd])) # idfk, noe Julia-magi
    end

    @show(p1, p2)
end

main()