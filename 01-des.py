# --- Day 1: Calorie Counting ---

def main():

    calories = []
    top_elf = 0
    top_three = 0

    with open("01-des.txt", "r") as file:
        elves = file.read().split("\n\n")
        for i in range(len(elves)):
            elves[i] = [int(cal) for cal in elves[i].split("\n")]

        for elf in elves:
            calories.append(sum(elf))

        if not top_elf:
            top_elf = max(calories)
        for i in range(3):
            top_three += max(calories)
            calories.pop(calories.index(max(calories)))

        print(f"""
    Top Elf: \t {top_elf}
    Top Three: \t {top_three}
    """)


if __name__ == "__main__":
    main()
