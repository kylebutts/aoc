input = readlines("2022/8/input.txt") 

input = map(x -> parse.(Int, split(x, "")), input) 
input = vcat(input'...)

nrow, ncol = size(input)
visible = zeros(Int, size(input))

# From left
for i in 1:nrow
  max_height = -1
  for j in 1:ncol
    if(input[i,j] > max_height)
      max_height = input[i, j]
      visible[i, j] = 1
    end
  end
end

# From right
for i in 1:nrow
  max_height = -1
  for k in 1:ncol
    j = ncol - k + 1
    if(input[i, j] > max_height)
      max_height = input[i, j]
      visible[i, j] = 1
    end
  end
end

# From top
for j in 1:ncol
  max_height = -1
  
  for i in 1:nrow
    if(input[i,j] > max_height)
      max_height = input[i, j]
      visible[i, j] = 1
    end
  end
end

# From bottom
for j in 1:ncol
  max_height = -1
  for k in 1:nrow
    i = nrow - k + 1

    if(input[i, j] > max_height)
      max_height = input[i, j]
      visible[i, j] = 1
    end
  end
end

sum(visible)







