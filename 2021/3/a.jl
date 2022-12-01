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

column_modes = mapslices(mode, input; dims = 1)
γ_string = string(column_modes...)
γ_rate = parse(Int, γ_string; base = 2)

ϵ_string = string((1 .- column_modes)...)
ϵ_rate = parse(Int, ϵ_string; base = 2)

power_consumption = γ_rate * ϵ_rate



