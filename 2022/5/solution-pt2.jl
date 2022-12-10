input = readlines("2022/5/input.txt") 

# Parse input
dirs = match.(
  r"move ([0-9]+) from ([0-9]+) to ([0-9]+)",
  input
)
setup = input[dirs .== nothing]
dirs = dirs[dirs .!= nothing]

# Parse setup
rownums_idx = occursin.(r"[0-9]", setup) |> 
  (x -> findall(x)[1])
rownums = setup[rownums_idx] |> 
  (x -> split(x, " ")) |>
  (x -> x[x .!= ""])|> 
  (x -> parse.(Int, x)) |> 
  (x -> maximum(x))

stacks = [Char[] for _ in 1:rownums]

regex = [raw"[\[ ]([A-Z ])[\] ]" for _ in 1:rownums]
regex = Regex(join(regex, " "))
matches = match.(
  regex, 
  reverse(setup[1:rownums_idx-1])
)

for row in matches
  row = collect(row)
  for i in eachindex(row)
    el = row[i]
    el = convert(Char, el[1])
    if (el !== nothing) & (el != ' ')
      push!(stacks[i], el)
    end
  end
end


# Apply instructions
# row = dirs[1]

for row in dirs
  N_move = parse(Int, row[1])
  from = parse(Int, row[2])
  to = parse(Int, row[3])
  temp = Char[]

  for i in 1:N_move 
    el = pop!(stacks[from])
    pushfirst!(temp, el)
  end
  append!(stacks[to], temp)
end

join(map(x -> x[end], stacks), "")

