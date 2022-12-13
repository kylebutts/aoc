input = readlines("2022/11/input.txt") 

mutable struct Monkey
  id::Int128
  items::Vector{Int128}
  operator::Function
  modulo::Int128
  true_to::Int128
  false_to::Int128
  N_inspections::Int128
end

function Base.show(io::IO, obj::Monkey)
  print(io, "Monkey $(obj.id)\n  items: $(join(obj.items, ' '))\n  N_inspections: $(obj.N_inspections)")
end

n_monkeys = match.(r"Monkey ([0-9]+):", input) |>
  (x -> map(y -> y === nothing ? "0" : y[1], x)) |> 
  (x -> parse.(Int128, x)) |>
  (x -> maximum(x) + 1)

monkeys_text = [input[(1 + (i-1)*7):(6 + (i-1)*7)] for i in 1:n_monkeys]

generate_operator = function(temp)
  operations = Dict(
    "*" => *,
    "+" => +
  ) 
  operator = operations[temp[2]]
  if (temp[1] == "old") & (temp[3] == "old")
    return (x) -> operator(x, x)
  elseif temp[1] == "old"
    return (x) -> operator(x, parse(Int128, temp[3]))
  end
end

# Parse monkeys ----------------------------------------------------------------
monkeys = Monkey[]

for monkey_text in monkeys_text

  id = match(r"Monkey ([0-9]+):", monkey_text[1])[1] |>
    (x -> parse(Int128, x))

  items = match(r"Starting items: (.*)$", monkey_text[2])[1] |>
    (x -> split(x, ", ")) |>
    (x -> parse.(Int128, x))


  temp = match(r"Operation: new = (.*) ([*+]) (.*)", monkey_text[3])
  operator = generate_operator(temp)

  modulo = match(r"Test: divisible by (.*)", monkey_text[4])[1] |>
    (x -> parse(Int128, x))

  true_to = match(r"If true: throw to monkey (.*)", monkey_text[5])[1] |>
    (x -> parse(Int128, x))
  false_to = match(r"If false: throw to monkey (.*)", monkey_text[6])[1] |>
    (x -> parse(Int128, x))
  
  monkey = Monkey(
    id,
    items,
    operator,
    modulo,
    true_to,
    false_to,
    0
  )

  monkeys = push!(monkeys, monkey)
end


# Play games pt. 1 -------------------------------------------------------------

function play_pt1(monkeys)
  for iter = 1:20
    for i in eachindex(monkeys)
      for j in eachindex(monkeys[i].items)
        monkeys[i].N_inspections += 1

        monkeys[i].items[j] = monkeys[i].operator(monkeys[i].items[j])

        # monkeys[i].items[j] = monkeys[i].items[j] % prod_modulo
        monkeys[i].items[j] = floor(monkeys[i].items[j] / 3)
        
        if monkeys[i].items[j] % monkeys[i].modulo == 0
          push!(monkeys[monkeys[i].true_to + 1].items, monkeys[i].items[j])
        else
          push!(monkeys[monkeys[i].false_to + 1].items, monkeys[i].items[j])
        end
      end

      # empty array
      while(length(monkeys[i].items) > 0)
        pop!(monkeys[i].items)
      end
    end
  end

  return(monkeys)
end

monkeys_pt1 = play_pt1(deepcopy(monkeys))

# Answer
map(y -> y.N_inspections, monkeys_pt1) |>
  (x -> sort!(x)) |> 
  (x -> last(x, 2)) |>
  (x -> *(x...))

# Play games pt. 2 -------------------------------------------------------------

function play_pt2(monkeys)
  prod_modulo = map(y -> y.modulo, monkeys) |> 
    (x -> *(x...))

  for iter = 1:10000
    for i in eachindex(monkeys)
      for j in eachindex(monkeys[i].items)
        monkeys[i].N_inspections += 1

        monkeys[i].items[j] = monkeys[i].operator(monkeys[i].items[j])

        monkeys[i].items[j] = monkeys[i].items[j] % prod_modulo
        # monkeys[i].items[j] = floor(monkeys[i].items[j] / 3)
        
        if monkeys[i].items[j] % monkeys[i].modulo == 0
          push!(monkeys[monkeys[i].true_to + 1].items, monkeys[i].items[j])
        else
          push!(monkeys[monkeys[i].false_to + 1].items, monkeys[i].items[j])
        end
      end

      # empty array
      while(length(monkeys[i].items) > 0)
        pop!(monkeys[i].items)
      end
    end
  end

  return monkeys
end

monkeys_pt2 = play_pt2(monkeys)

# Answer
map(y -> y.N_inspections, monkeys_pt2) |>
  (x -> sort!(x)) |> 
  (x -> last(x, 2)) |>
  (x -> *(x...))



