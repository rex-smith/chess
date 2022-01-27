module Space
  def numberPosition(char_position)
    column = char_position[0].ord - 97
    row = -1*(char_position[1].to_i-8)
    numbered = [row, column]
    return numbered
  end

  def charPosition(num_position)
    # Is this the right function from ord to char?
    column = (num_position[0] + 97).chr
    row = -1*(num_position[1]) + 8
    char = [row, column]
    return char
  end
end