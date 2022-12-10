# --- Day 10: Cathode-Ray Tube ---

function get_signal_strength(cycle::Int, register::Int)
    (cycle - 20) % 40 == 0 ? cycle * register : 0
end

function draw_pixel!(screen::Matrix{Char}, cycle::Int, register::Int)
    line = Int(trunc(cycle/40) + 1)
    pixel_pos = cycle - (40 * (line - 1))
    sprite = [register-1, register, register+1]
    if pixel_pos in sprite
        screen[line, pixel_pos + 1] = '█'
    end
end

function display(screen::Matrix{Char})
    for x in axes(screen, 1), y in axes(screen, 2)
        print(screen[x, y])
        if y % 40 == 0 print('\n') end
    end
end

function run_program(program)
    reg_a = 1
    cycle = 0
    signal_strength = 0
    screen = fill(' ', (6, 40))

    for instr in program
        if instr[1] == "noop" 
            draw_pixel!(screen, cycle, reg_a)
            cycle += 1 
            signal_strength += get_signal_strength(cycle, reg_a)
        end
        if instr[1] == "addx"
            draw_pixel!(screen, cycle, reg_a)
            for _ in 1:2
                draw_pixel!(screen, cycle, reg_a)
                cycle += 1
                signal_strength += get_signal_strength(cycle, reg_a)
            end 
            reg_a += parse(Int, instr[2])
        end
    end
    return signal_strength, screen
end

function main()
    program = split.(readlines("10-des.txt"))

    println("Part 1: ", run_program(program)[1])
    println("Part 2:")
    display(run_program(program)[2])

end

main()