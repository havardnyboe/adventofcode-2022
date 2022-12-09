# --- Day 9: Rope Bridge ---

# Tidlig-stadie av traumatisk kode og forsøk på debugging i python

def adjacent_nodes(node1, node2):
    return -1 <= node1[0] - node2[0] <= 1 and -1 <= node1[1] - node2[1] <= 1


def get_unique_tail_positions(head, tail, moves):
    tail_positions = []

    for move in moves:
        for _ in range(move[1]):
            if move[0] == 'R':
                head[0] += 1
                if not adjacent_nodes(tail, head):
                    tail[0] = head[0]-1
                    tail[1] = head[1]
            elif move[0] == 'L':
                head[0] -= 1
                if not adjacent_nodes(tail, head):
                    tail[0] = head[0]+1
                    tail[1] = head[1]
            elif move[0] == 'U':
                head[1] += 1
                if not adjacent_nodes(tail, head):
                    tail[0] = head[0]
                    tail[1] = head[1]-1
            elif move[0] == 'D':
                head[1] -= 1
                if not adjacent_nodes(tail, head):
                    tail[0] = head[0]
                    tail[1] = head[1]+1
            tail_positions.append(tuple(tail))

    return len(set(tail_positions))


def main():
    with open("09-des.txt", "r") as file:
        moves = []
        for line in file:
            # line = line.split()
            moves.append([line[0], int(line[1])])

    head = [0, 0]
    tail = [0, 0]

    # print(moves)

    print("Part 1: ", get_unique_tail_positions(head, tail, moves))


if __name__ == "__main__":
    main()
