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
        pocket_1, pocket_2 = set(sack[:len(sack)//2]), set(sack[len(sack)//2:])
        priority_sum += get_priority(pocket_1.intersection(pocket_2).pop())

    print("Part 1:\t", priority_sum)

    # --- Part Two ---
    for i in range(0, len(knapsacks), 3):
        sack_1, sack_2, sack_3 = knapsacks[i:i+3]
        badge_sum += get_priority(set(sack_1).intersection(
            set(sack_2).intersection(set(sack_3))).pop())

    print("Part 2:\t", badge_sum)


if __name__ == "__main__":
    main()
