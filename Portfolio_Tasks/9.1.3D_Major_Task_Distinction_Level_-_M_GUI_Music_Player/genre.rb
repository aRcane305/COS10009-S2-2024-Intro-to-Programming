# frozen_string_literal: true

module Genre
  POP, DANCE, HIP_HOP_RAP, CLASSIC, JAZZ, SOUL, ROCK, ALTERNATIVE_INDIE = *1..8

  GENRES = {
    1 => POP,
    2 => DANCE,
    3 => HIP_HOP_RAP,
    4 => CLASSIC,
    5 => JAZZ,
    6 => SOUL,
    7 => ROCK,
    8 => ALTERNATIVE_INDIE
  }.freeze
end