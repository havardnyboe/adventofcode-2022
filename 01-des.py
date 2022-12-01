# --- Day 1: Calorie Counting ---
# ikke vakkert men det funker :P

def main():

  calories: list = []
  top_elf: int = 0
  top_three: int = 0

  with open("01-des.txt", "r") as file:
    elves = file.read().split("\n\n")
    for i in range(len(elves)):
      try:
        elves[i] = [int(cal) for cal in elves[i].split("\n")]
      except ValueError:
        pass

    for elf in elves:
      try:
        calories.append(sum(elf))
      except TypeError:
        pass

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