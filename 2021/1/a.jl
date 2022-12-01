

input = readlines("2021/1/input.txt") 
input = parse.(Int16, input)

increased = zeros(length(input))

for i in 2:length(input)
  if input[i-1] < input[i]
    increased[i] = 1
  end
end

print(sum(increased))
  


