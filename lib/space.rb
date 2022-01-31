module Space
  
  def numberPosition(char_position)
    x = char_position[0].ord - 97
    y = -1*(char_position[1].to_i-8)
    numbered = [x, y]
    return numbered
  end

  def charPosition(num_position)
    x = (num_position[0] + 97).chr
    y = -1*(num_position[1]) + 8
    char = x.to_s + y.to_s
    return char
  end
end