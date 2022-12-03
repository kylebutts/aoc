input = readlines("2022/3/input.txt")

matches = Char[]

groups = collect(-2 .+ (1:length(input)/3) .* 3) |> 
  (x -> convert(Vector{Int}, x))

for idx in groups
  first = collect(input[idx])
  second = collect(input[idx+1])
  third = collect(input[idx+2])

  match1 = first[map(x -> x ∈ second, first)]
  match2 = second[map(x -> x ∈ third, second)]
  match = match1[map(x -> x ∈ match2, match1)][1]

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



