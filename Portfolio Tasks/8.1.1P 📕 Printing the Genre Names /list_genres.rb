module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..4
end

Genre_names = ["Null", "1 Pop", "2 Classic", "3 Jazz", "4 Rock"]

def main()
  index = 1
  count = 4
  while index <= count
    puts(Genre_names[index])
    index += 1
  end

end

main()
