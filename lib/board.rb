require_relative 'player'
require_relative 'space'

class Board
  include Space
  def initialize
    @board = Array.new(8) {Array.new(8) {' '}}
    @potential_board = @board
    @white = Player.new('white', self)
    @black = Player.new('black', self)
    @active_player = @white
    @active_enemy = @black
  end

  attr_reader :active_player
  attr_accessor :board

  def displayBoard
    @board.each_with_index do |row, index|
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
    @board = Array.new(8) {Array.new(8) {' '}}

    @white.pieces.each do |name, piece|
      column = piece.num_position[1]
      row = piece.num_position[0]
      @board[row][column] = piece 
    end

    @black.pieces.each do |name, piece|
      column = piece.num_position[1]
      row = piece.num_position[0]
      @board[row][column] = piece 
    end
    @potential_board = @board
  end

  def updatePotentialBoard

  end

  def onBoard?(position)
    position[0].between?(0,7) && position[1].between?(0,7)
  end

  def occupied_enemy?(position)
    if @board[position[0], position[1]].color == active_enemy.color
      return true
    end
    return false
  end

  def occupied_self?(position)
    if @board[position[0], position[1]].color == active_player.color
      return true
    end
    return false
  end
end