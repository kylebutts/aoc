using RollingFunctions

input = readlines("2021/1/input.txt") 
input = parse.(Int16, input)

rolling = rollmean(input, 3) .* 3


increased = zeros(length(rolling))

for i in 2:length(rolling)
  if rolling[i-1] < rolling[i]
    increased[i] = 1
  end
end

print(sum(increased))
