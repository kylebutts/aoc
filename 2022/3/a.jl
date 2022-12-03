input = readlines("2022/3/input.txt")

matches = Char[]

for line in input
  half = Int(length(line)/2)
  first = collect(line[1:half])
  second = collect(line[half+1:end])

  match = first[map(x -> x ∈ second, first)][1]
  push!(matches, match)
end

matches_int = convert(Vector{Int}, matches)

# ASCII Code to points
# Capitals
matches_int[(matches_int .<= 96)] = 
  matches_int[(matches_int .<= 96)] .- 65 .+ 27
# lowercase
matches_int[(matches_int .>= 97)] = 
  matches_int[(matches_int .>= 97)] .- 97 .+ 1

sum(matches_int)



