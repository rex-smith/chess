Module Space
  def numberPosition(position)
    column = position[0].ord - 97
    row = -1*(position[1].to_i-8)
    numbered = [row, column]
    return numbered
  end
end