input = readlines("2022/4/input.txt")


# Part 1
count = 0
for line in input
  range1 = split(line, ",")[1]
  range2 = split(line, ",")[2]

  range11 = parse(Int, split(range1, "-")[1])
  range12 = parse(Int, split(range1, "-")[2])
  range21 = parse(Int, split(range2, "-")[1])
  range22 = parse(Int, split(range2, "-")[2])

  range1 = collect(range11:range12)
  range2 = collect(range21:range22)

  if all(map(x -> x ∈ range2, range1)) | all(map(x -> x ∈ range1, range2)) 
    count += 1
  end
end

println(count)

# Part 2

count = 0
for line in input
  range1 = split(line, ",")[1]
  range2 = split(line, ",")[2]

  range11 = parse(Int, split(range1, "-")[1])
  range12 = parse(Int, split(range1, "-")[2])
  range21 = parse(Int, split(range2, "-")[1])
  range22 = parse(Int, split(range2, "-")[2])

  range1 = collect(range11:range12)
  range2 = collect(range21:range22)

  if any(map(x -> x ∈ range2, range1)) | any(map(x -> x ∈ range1, range2)) 
    count += 1
  end
end

println(count)



