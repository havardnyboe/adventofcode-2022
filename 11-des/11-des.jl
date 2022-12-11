# --- Day 11: Monkey in the Middle ---

mutable struct Monkey
    items::Vector{Int}
    expression::String
    test::Int
    throw_true::Int
    throw_false::Int
    inspected::Int
end

function Monkey(items::Vector{Int}, expression::String, test::Int, throw_true::Int, throw_false::Int)
    Monkey(items, expression, test, throw_true + 1, throw_false + 1, 0)
end

function Base.display(monkey::Monkey, name=nothing)
    # println("Monkey", name === nothing ? "" : " $name")
    # println("  Items: $(monkey.items)")
    # println("  Operation: new = $(monkey.expression)")
    # println("  Test: divisible by $(monkey.test)")
    # println("    If true: throw to monkey $(monkey.throw_true-1)")
    # println("    If false: throw to monkey $(monkey.throw_false-1)\n")
    println("Monkey $name inspected: $(monkey.inspected) times")
end

function Base.display(monkeys::AbstractArray{Monkey})
    for (i, monkey) in enumerate(monkeys)
        display(monkey, i - 1)
    end
end

function calculate(expression::String, old::Int)
    ex = split(expression)
    try
        num = parse(Int, ex[3])
        if ex[2] == "+"
            return old + num
        elseif ex[2] == "*"
            return old * num
        end
    catch error
        if isa(error, ArgumentError)
            if ex[2] == "+"
                return old + old
            elseif ex[2] == "*"
                return old * old
            end
        else
            rethrow(error)
        end
    end
end

function inspect_item(item::Int, monkey::Monkey, mod::Int, stressed::Bool)
    monkey.inspected += 1
    if stressed
        return calculate(monkey.expression, item) % mod
    end
    floor(calculate(monkey.expression, item) / 3)

end

function do_mokey_business(monkeys::Vector{Monkey}, stressed::Bool = false)
    mod = prod(m.test for m in monkeys)
    for monkey in monkeys
        while length(monkey.items) > 0
            item = popfirst!(monkey.items)
            new_item = inspect_item(item, monkey, mod, stressed)

            if new_item % monkey.test == 0
                push!(monkeys[monkey.throw_true].items, new_item)
            else
                push!(monkeys[monkey.throw_false].items, new_item)
            end
        end
    end
end

function get_level_of_mokey_business(monkeys::Vector{Monkey})
    business = Int[]
    for monkey in monkeys
        push!(business, monkey.inspected)
    end
    sort!(business, rev=true)
    business[1] * business[2]
end

function main()
    monkeys_test = Monkey[
        Monkey([79, 98], "old * 19", 23, 2, 3)
        Monkey([54, 65, 75, 74], "old + 6", 19, 2, 0)
        Monkey([79, 60, 97], "old * old", 13, 1, 3)
        Monkey([74], "old + 3", 17, 0, 1)]
    monkeys_p1 = Monkey[
        Monkey([50, 70, 54, 83, 52, 78], "old * 3", 11, 2, 7)
        Monkey([71, 52, 58, 60, 71], "old * old", 7, 0, 2)
        Monkey([66, 56, 56, 94, 60, 86, 73], "old + 1", 3, 7, 5)
        Monkey([83, 99], "old + 8", 5, 6, 4)
        Monkey([98, 98, 79], "old + 3", 17, 1, 0)
        Monkey([76], "old + 4", 13, 6, 3)
        Monkey([52, 51, 84, 54], "old * 17", 19, 4, 1)
        Monkey([82, 86, 91, 79, 94, 92, 59, 94], "old + 7", 2, 5, 3)]
    monkeys_p2 = deepcopy(monkeys_p1)

    print("Part 1: ")
    for _ in 1:20
        do_mokey_business(monkeys_p1)
    end
    print("$(get_level_of_mokey_business(monkeys_p1))\n")

    print("Part 2: ")
    for i in 1:10000
        do_mokey_business(monkeys_p2, true)
        # if i % 1000 == 0 || i == 1 || i == 20
        #     println("\n== After round $i ==")
        #     display(monkeys_p2)
        # end
    end
    print("$(get_level_of_mokey_business(monkeys_p2))\n")

end

main()