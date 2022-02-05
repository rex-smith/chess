require_relative 'player'
require_relative 'space'
require_relative 'save_load'
require 'yaml'
require 'json'

class Board
  include Space
  extend SaveLoad

  def initialize(white=Player.new('white', self),black=Player.new('black', self))
    @white = white
    @black = black
    set_enemies
    @active_player = @white.turns == @black.turns ? @white : @black
    @active_enemy = @active_player.enemy
    @grid = Array.new(8) {Array.new(8) {' '}}
  end

  attr_accessor :grid, :active_player, :active_enemy, :white, :black

  def set_enemies
    @white.enemy = @black
    @black.enemy = @white
  end

  def displayBoard
    updateBoard
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
    @white.print_removed_symbols
    @black.print_removed_symbols
    puts "White is in check" if @white.check?
    puts "Black is in check" if @black.check?
    puts
  end

  def updateBoard
    @grid = Array.new(8) {Array.new(8) {' '}}

    @white.pieces.each do |piece|
      y = piece.num_position[1]
      x = piece.num_position[0]
      @grid[y][x] = piece 
    end

    @black.pieces.each do |piece|
      y = piece.num_position[1]
      x = piece.num_position[0]
      @grid[y][x] = piece 
    end
  end

  def onBoard?(position)
    position[0].between?(0,7) && position[1].between?(0,7)
  end

  def contains_piece?(position)
    if @grid[position[1]][position[0]].is_a? Piece
      return true
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