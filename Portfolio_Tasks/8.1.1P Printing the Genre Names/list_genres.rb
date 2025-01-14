# frozen_string_literal: true

module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..4

  $Genre_names = ['Null', '1 Pop', '2 Classic', '3 Jazz', '4 Rock'].freeze
end

def main
  index = 1
  count = 4
  while index <= count
    puts($Genre_names[index])
    index += 1
  end
end

main
