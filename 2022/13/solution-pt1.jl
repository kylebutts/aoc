input = readlines("2022/13/input.txt") 
input = input[input .!= ""]

# input -> Expr -> eval
input = map(y -> eval(Meta.parse(y)), input)

function Base.isless(x::Int, y::AbstractVector)
  return [x] < y
end
function Base.isless(x::AbstractVector, y::Int)
  return x < [y]
end
function Base.isequal(x::Int, y::AbstractVector)
  return isequal([x], y)
end
function Base.isequal(x::AbstractVector, y::Int)
  return isequal(x, [y])
end

# x > y => false, x < y => true
function compare_elements(x, y, pos = 1)
  # println("position: $(pos)")
  # x ran out of elements
  if !isassigned(x, pos) & isassigned(y, pos)
    return true
  end
  if !isassigned(x, pos) & !isassigned(y, pos)
    return true
  end
  # y ran out of elements
  if isassigned(x, pos) & !isassigned(y, pos)
    return false
  end

  if x[pos] < y[pos]
    # println("$(x[pos]) < $(y[pos])")
    return true
  elseif y[pos] < x[pos]
    # println("$(x[pos]) > $(y[pos])")
    return false
  else
    # println("$(x[pos]) == $(y[pos])")
    return compare_pair(x, y, pos + 1)
  end
end

# Part 1
pairs = [input[(-1 + i*2):(i*2)] for i in Int(1):Int(length(input)/2)]

ordered_correct = map(pair -> compare_elements(pair[1], pair[2]), pairs)
println(sum(findall(ordered_correct)))

# Part 2
dividers = [[[2]], [[6]]]
input_pt2 = append!(input, dividers)

sort!(input_pt2, lt = (x, y) -> compare_elements(x, y))

println(prod(findall(el -> el ∈ dividers, input_pt2)))



