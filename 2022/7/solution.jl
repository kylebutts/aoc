input = readlines("2022/7/input.txt") 

dir = Dict()
cd = []

for row in input
  dollar, cmd, cmd_dir = match(r"(\$)? ?(cd|ls|dir|[0-9]+) ?(.*)", row)
  # println(dollar, " ", cmd, " ", cmd_dir)

  if cmd == "cd"
    if cmd_dir == ".."
      pop!(cd)
    else 
      push!(cd, cmd_dir)
      if !(cd in keys(dir))
        dir[(cd...)] = Dict("mem" => 0)
      end
    end
  elseif (cmd == "dir") | (cmd == "ls")

  else 
    temp = copy(cd)
    while temp != []
      dir[temp...]["mem"] += parse(Int, cmd)
      pop!(temp)
    end
  end
end

# Part 1
mem_sum = 0
for (k, v) in dir
  if v["mem"] < 100_000
    mem_sum += v["mem"]
  end
end

println(mem_sum)


# Part 2
remaining_space = (70_000_000 - dir["/"]["mem"])
space_needed = 30_000_000 - remaining_space
curr_smallest = Inf

for (k, v) in dir
  if (v["mem"] > space_needed) & (v["mem"] < curr_smallest)
    curr_smallest = v["mem"]
  end
end

println(curr_smallest)

