input = readlines("2022/12/input.txt") 
input = map(
  x -> [convert(Char, String(z)[1]) for z in split(x, "")], 
  input
)
input = mapreduce(permutedims, vcat, input)

INPUT_SIZE = [size(input)[1] size(input)[2]]

# Find start and ending locations
S_pos = findfirst(input .== 'S')
S_pos = [S_pos[1], S_pos[2]]
input[S_pos...] = 'a'

E_pos = findfirst(input .== 'E')
E_pos = [E_pos[1], E_pos[2]]
input[E_pos...] = 'z'


# Djikstra's Algorithm
get_reachable_neighbors = function(curr, visited, input)
  potential = [
    [curr[1] + 1, curr[2]],
    [curr[1] - 1, curr[2]],
    [curr[1], curr[2] + 1],
    [curr[1], curr[2] - 1]
  ]
  
  valid = filter(
    function(y)
      (INPUT_SIZE[1] >= y[1] > 0) & (INPUT_SIZE[2] >= y[2] > 0)
    end, 
    potential
  )

  nonvisited = filter(y -> !(y in visited), valid)

  filter(
    function(y)
      input[y...] - input[curr...] <= 1
    end,
    nonvisited
  )
end

get_vertex_idx = function(pos)
  return (pos[1] - 1) * (INPUT_SIZE[2]) + (pos[2])
end

vertices = [
  [
    ceil(el / INPUT_SIZE[2]), 
    el - floor((el - 1) / INPUT_SIZE[2]) * INPUT_SIZE[2]
  ] 
  for el in 1:INPUT_SIZE[1]*INPUT_SIZE[2]
]

lowest_cost = [Inf for i in 1:length(vertices)]


# Set starting point to 0
lowest_cost[get_vertex_idx(S_pos)] = Int64(0)

visited = []
toVisit = [S_pos]

while length(toVisit) > 0 
  
  curr = popfirst!(toVisit)
  curr_value = input[curr...]

  # Check if already visited curr
  if curr in visited 
    continue
  end

  # Get reachable neighbors to `curr`
  reachable_neighbors = get_reachable_neighbors(curr, visited, input)
  push!(toVisit, reachable_neighbors...)

  costToCurr = lowest_cost[get_vertex_idx(curr)]
  
  for neighbor in reachable_neighbors
    newCost = costToCurr + Int64(1)
    idx = get_vertex_idx(neighbor)

    lowest_cost[idx] = lowest_cost[idx] == Inf ? newCost : lowest_cost[idx]
  end
  push!(visited, curr)
end

println(
  lowest_cost[get_vertex_idx(E_pos)]
)


