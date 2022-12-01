input = readlines("2021/2/input.txt") 

location = [0, 0]
aim = 0
for row in input
  direction = split(row, " ")[1]
  distance = split(row, " ")[2] |> 
    (x -> parse(Int, x))

  if direction == "forward"
    location[1] += distance
    location[2] += distance * aim
  elseif direction == "down"
    aim += distance
  elseif direction == "up" 
    aim -= distance
  end
end

location[1] * location[2]
