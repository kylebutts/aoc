using StructArrays
input = readlines("2022/2/input.txt")

input = vcat(input...)
input = split.(input, " ")


DictOpponent = Dict("A" => "R", "B" => "P", "C" => "S")
DictMine = Dict("X" => "R", "Y" => "P", "Z" => "S")
DictPoints = Dict(
  ("R", "R") => [1 + 3, 1 + 3],
  ("R", "P") => [1 + 0, 2 + 6],
  ("R", "S") => [1 + 6, 3 + 0],
  ("P", "R") => [2 + 6, 1 + 0],
  ("P", "P") => [2 + 3, 2 + 3],
  ("P", "S") => [2 + 0, 3 + 6],
  ("S", "R") => [3 + 0, 1 + 6],
  ("S", "P") => [3 + 6, 2 + 0],
  ("S", "S") => [3 + 3, 3 + 3],
)
scores = Int16[0, 0]

for index in eachindex(input)
  row = input[index]

  # convert to RPS
  opponent_move = DictOpponent[row[1]]
  my_move = DictMine[row[2]]

  scores .+= DictPoints[(opponent_move, my_move)]
end 

println("Opponent Score: $(scores[1]); My score: $(scores[2])")





