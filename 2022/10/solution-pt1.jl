input = readlines("2022/10/input.txt") 

function move_to_next_pixel(curr_pixel)
  if(curr_pixel[1] == 39) 
    curr_pixel = [0, curr_pixel[2] + 1]
  else 
    curr_pixel += [1, 0]
  end
end

WIDTH = 40
HEIGHT = 6
screen = [" " for i in 1:HEIGHT, j in 1:WIDTH]

val = 1
cycle = 0
history = [[cycle, val]]
# Need to be careful about indexing
curr_pixel = [0, 0]


for row in input
  cmd = match(r"^(addx|noop)", row)[1]
  if cmd == "addx"
    num = parse(Int16, split(row, " ")[2])
  end 

  cycles = Dict("addx" => 2, "noop" => 1)[cmd]

  for i in 1:cycles
    # History *during* the cycle
    cycle += 1
    push!(history, [cycle, val])

    # Part 2
    if abs(curr_pixel[1] - (val % 40)) <= 1
      screen[(reverse(curr_pixel) .+ [1, 1])...] = "█"
    end

    if (i == cycles) & (cmd == "addx")
      val += num
    end

    curr_pixel = move_to_next_pixel(curr_pixel)
  end
end

# Part 1
history |>
  (x -> filter(y -> y[1] ∈ [20, 60, 100, 140, 180, 220], x)) |>
  (x -> map(y -> y[1] * y[2], x)) |>
  sum

# Part 2
screen |> 
  (x -> mapslices(y -> join(y), x, dims = 2)) |>
  (x -> join(x, "\n")) |>
  print

