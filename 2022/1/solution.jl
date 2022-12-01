input = readlines("1/input.txt") 

elves = Int[]

curr_elf_calories = 0

for line in input
  if line == ""
    push!(elves, curr_elf_calories)
    curr_elf_calories = 0
  else 
    curr_elf_calories += parse(Int, line)
  end
end

# Part 1
maximum(elves)

# Part 2
sort!(elves)
elves[length(elves)-2:length(elves)] |> sum
