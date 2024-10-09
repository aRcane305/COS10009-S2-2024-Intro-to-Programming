# frozen_string_literal: true

def array_addition(data, val)
  i = 0
  result = false
  while i < data.length
    if data[i] == val
      result = true
      return result
    end
    i += 1
  end
  result
end
