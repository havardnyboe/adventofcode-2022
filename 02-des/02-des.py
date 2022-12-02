# --- Day 2: Rock Paper Scissors ---

print(sum((ord(me) - ord(elf) - 19) % 3 * 3 + ord(me) - 87 for elf,
      me in [game.split() for game in open('02-des.txt').read().strip().splitlines()]))

# --- Part Two ---

print(sum((ord(me) - 88) * 3 + (ord(elf) + ord(me) - 154) % 3 + 1 for elf,
      me in [game.split() for game in open('02-des.txt').read().strip().splitlines()]))
