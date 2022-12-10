input = readlines("2022/9/input.txt") 

function update_head!(head_pos, dir)
  update =   Dict(
    "L" => [-1, 0],
    "R" => [1, 0],
    "U" => [0, 1],
    "D" => [0, -1]
  )[dir]
  
  head_pos .+= update
end

function update_tail!(tail_pos, head_pos)
  dist = head_pos .- tail_pos
  update = [0, 0]
  if !all(abs.(dist) .<= 1)
    if (dist[1] == 0)
      update[1] = 0
      update[2] = (1 * (dist[2] > 0)) + (-1 * (dist[2] < 0))
    elseif (dist[2] == 0)
      update[1] = (1 * (dist[1] > 0)) + (-1 * (dist[1] < 0))
      update[2] = 0
    else 
      update[1] = (1 * (dist[1] > 0)) + (-1 * (dist[1] < 0))
      update[2] = (1 * (dist[2] > 0)) + (-1 * (dist[2] < 0))
    end
  end 
  tail_pos .+= update 
end

# Part 1
head_pos = [0, 0]
tail_pos = [0, 0]
tail_history = Set([tail_pos])

for row in input
  dir, times = split(row, " ")
  times = parse(Int16, times)

  for i in 1:times
    update_head!(head_pos, dir)
    update_tail!(tail_pos, head_pos)
    # println(tail_pos)
    push!(tail_history, copy(tail_pos))
  end
end 

length(tail_history)

# Part 2

positions = [[0, 0] for i in 1:10]
tail_history = Set([[0, 0]])

# for row in ["R 5", "U 8", "L 8", "D 3", "R 17", "D 10", "L 25", "U 20"]
for row in input
  dir, times = split(row, " ")
  times = parse(Int16, times)

  for i in 1:times
    update_head!(positions[1], dir)
    for j in 2:10
      update_tail!(positions[j], positions[j-1])
      push!(tail_history, copy(positions[10]))
    end
  end
end 

length(tail_history)



