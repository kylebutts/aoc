input = readlines("2021/2/input.txt") 

location = [0, 0]
for row in input
  direction = split(row, " ")[1]
  distance = split(row, " ")[2] |> 
    (x -> parse(Int, x))

  if direction == "forward"
    directionX = 1
    directionY = 0
  elseif direction == "down"
    directionX = 0
    directionY = 1
  elseif direction == "up" 
    directionX = 0
    directionY = -1
  end

  location[1] += directionX * distance
  location[2] += directionY * distance
end

location[1] * location[2]
