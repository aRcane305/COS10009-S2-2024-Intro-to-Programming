# frozen_string_literal: true

def whatdoesthisfunctiondo?(data)
  data = ["6", "-3", "3", "8", "1"]
  result = 0;
  i = 0
  while i < data.length
    result = result + data[ i ];
    i = i + 1
  end
  return result
end

def main()
  whatdoesthisfunctiondo?
end