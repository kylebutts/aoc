input = readlines("2022/8/input.txt") 

input = map(x -> parse.(Int, split(x, "")), input) 
input = vcat(input'...)

nrow, ncol = size(input)
scenic_score = ones(Int, size(input))

# Loop through trees 
for i in 1:nrow
  for j in 1:ncol
    # look left
    count = 0
    for k in 1:j-1
      if input[i, j - k] < input[i, j]
        count += 1
      else 
        count += 1
        break
      end
    end
    scenic_score[i, j] *= count

    # look right
    count = 0
    for k in 1:(ncol-j)
      if input[i, j + k] < input[i, j]
        count += 1
      else 
        count += 1
        break
      end
    end
    scenic_score[i, j] *= count

    # look up
    count = 0
    for k in 1:i-1
      if input[i - k, j] < input[i, j]
        count += 1
      else 
        count += 1
        break
      end
    end
    scenic_score[i, j] *= count

    # look down
    count = 0
    for k in 1:(nrow-i)
      if input[i + k, j] < input[i, j]
        count += 1
      else 
        count += 1
        break
      end
    end
    scenic_score[i, j] *= count
  end
end

println(maximum(scenic_score))






