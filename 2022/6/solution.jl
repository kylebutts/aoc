input = readlines("2022/6/input.txt") 
input = Char[input[1]...]

marker = 1
found = false
while found == false
  if 14 == (input[(marker):(marker + 13)] |> unique |> length)
    found = true
  else
    marker += 1
  end
end
print(marker + 13)

marker = 1
found = false
while found == false
  if 4 == (input[(marker):(marker + 3)] |> unique |> length)
    found = true
  else
    marker += 1
  end
end
print(marker + s3)





