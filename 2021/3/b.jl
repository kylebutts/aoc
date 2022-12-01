using StatsBase

input = readlines("2021/3/input.txt") 

# Convert to matrix
input = input |> 
  # Split row into bits
  (x -> split.(x, "") ) |>
  # Parse rows
  (x -> map(y -> parse.(Int, y), x)) |> 
  # Vector{Vector{Int}} to Matrix
  (x -> reduce(vcat, x'))

nrows = size(input)[1]
ncols = size(input)[2]


# Oxygen Generator Rating
master_idx = ones(Int, nrows)
for col_j in 1:ncols
  col = input[master_idx .== 1, col_j]
  
  if length(col) == 1
    break
  end
  
  n_0 = sum(col .== 0)
  n_1 = sum(col .== 1)

  if n_0 > n_1
    master_idx[master_idx .== 1] = 
      master_idx[master_idx .== 1] .* (col .== 0)
  else
    master_idx[master_idx .== 1] = 
      master_idx[master_idx .== 1] .* (col .== 1)    
  end
end

oxygen_generator_rating = input[master_idx .== 1, :] |>
  (x -> string(x...)) |> 
  (x -> parse(Int, x; base = 2))


# CO2 Scrubber Rating
master_idx = ones(Int, nrows)
for col_j in 1:ncols
  col = input[master_idx .== 1, col_j]
  
  if length(col) == 1
    break
  end
  
  n_0 = sum(col .== 0)
  n_1 = sum(col .== 1)

  if n_0 > n_1
    master_idx[master_idx .== 1] = 
      master_idx[master_idx .== 1] .* (col .== 1)
  else
    master_idx[master_idx .== 1] = 
      master_idx[master_idx .== 1] .* (col .== 0)    
  end
end

co2_scrubber_rating = input[master_idx .== 1, :] |>
  (x -> string(x...)) |> 
  (x -> parse(Int, x; base = 2))


print(oxygen_generator_rating * co2_scrubber_rating)
