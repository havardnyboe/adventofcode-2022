# --- Day 4: Camp Cleanup ---

def main():
    contained_pairs = 0
    intersected_pairs = 0

    with open("04-des.txt", "r") as file:
        elf_pairs = [x.split(",") for x in file.read().strip().splitlines()]

        for pair in elf_pairs:
            elf_1 = {x for x in range(int(pair[0].split("-")[0]),
                                      int(pair[0].split("-")[1]) + 1)}
            elf_2 = {x for x in range(int(pair[1].split("-")[0]),
                                      int(pair[1].split("-")[1]) + 1)}

            if elf_1.issubset(elf_2) or elf_2.issubset(elf_1):
                contained_pairs += 1

            if elf_1.intersection(elf_2) or elf_2.intersection(elf_1):
                intersected_pairs += 1

    print(f"Part 1:\t{contained_pairs}\nPart 2:\t{intersected_pairs}")


if __name__ == "__main__":
    main()
