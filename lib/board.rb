require_relative 'player'
require_relative 'space'

class Board
  include Space
  def initialize
    @grid = Array.new(8) {Array.new(8) {' '}}
    @white = Player.new('white', self)
    @black = Player.new('black', self)
    @active_player = @white
    @active_enemy = @black
  end

  attr_accessor :real_grid, :test_grid, :active_player, :active_enemy, :white, :black

  def displayBoard
    @grid.each_with_index do |row, index|
      print "#{-1*(index-8)} "
      row.each do |piece|
        if piece == ' '
          print "[#{piece}]"
        else
          print "[#{piece.symbol}]"
        end
      end
      print "\n"
    end
    print "   A  B  C  D  E  F  G  H\n"
    puts
  end

  def updateBoard
    @grid = Array.new(8) {Array.new(8) {' '}}

    @white.pieces.each do |name, piece|
      y = piece.num_position[1]
      x = piece.num_position[0]
      @grid[y][x] = piece 
    end

    @black.pieces.each do |name, piece|
      y = piece.num_position[1]
      x = piece.num_position[0]
      @grid[y][x] = piece 
    end
  end

  def onBoard?(position)
    position[0].between?(0,7) && position[1].between?(0,7)
  end

  def occupied_enemy?(position)
    if @grid[position[0]][position[1]].color == @active_enemy.color
      return true
    end
    return false
  end

  def occupied_self?(position)
    unless @grid[position[0]][position[1]] == ' '
      if @grid[position[0]][position[1]].color == @active_player.color
        return true
      end
    end
    return false
  end

  def change_active
    if @active_player == @white
      @active_player = @black
      @active_enemy = @white
    else
      @active_player = @white
      @active_enemy = @black
    end
  end
end