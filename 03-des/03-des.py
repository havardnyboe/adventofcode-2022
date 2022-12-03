# --- Day 3: Rucksack Reorganization ---

def get_priority(char: str) -> int:
    if ord(char) < 97:
        p = ord(char) - 38
    if ord(char) >= 97:
        p = ord(char) - 96
    return p


def main():
    priority_sum = 0
    badge_sum = 0

    with open("03-des.txt", "r") as file:
        knapsacks = file.read().strip().splitlines()

    for sack in knapsacks:
        comp1 = set(sack[:len(sack)//2])
        comp2 = set(sack[len(sack)//2:])
        priority_sum += get_priority(comp1.intersection(comp2).pop())

    print(priority_sum)

    # --- Part Two ---
    for i in range(0, len(knapsacks), 3):
        sack1 = set(knapsacks[i])
        sack2 = set(knapsacks[i + 1])
        sack3 = set(knapsacks[i + 2])
        badge_sum += get_priority(sack1.intersection(
            sack2.intersection(sack3)).pop())

    print(badge_sum)


if __name__ == "__main__":
    main()
