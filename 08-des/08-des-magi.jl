# mega brain kode jeg fant på webben, forsøk på å dekode den...

function main()
    forrest = parse.(Int64, reduce(hcat, collect.(readlines("08-des.txt"))))

    p1 = p2 = 0
    for x in axes(forrest, 1), y in axes(forrest, 2)
        tree = forrest[x, y] # current tree
        lrtb = [forrest[x-1:-1:1, y], forrest[x+1:end, y], forrest[x, y-1:-1:1], forrest[x, y+1:end]] # matrise med høyden til trær til hhv. venstre, høyre, opp, ned
        p1 += any(tree .> maximum.(lrtb, init=-Inf)) ? 1 : 0 # finner max visibility med fancy Julia dot-notation, hvis current tree er større enn største naboene, p1++
        p2 = max(p2, prod([something(findfirst(i -> i >= tree, vec(j)), length(j)) for j in lrtb])) # idfk, noe Julia-magi. Finner noe lengder og ganger de i guess...
    end

    @show(p1, p2)
end

main()