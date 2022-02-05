require_relative 'piece'
require_relative 'space'
require_relative 'save_load'
require 'json'

class Player
  include Space
  extend SaveLoad
  
  def initialize(color, board, pieces=[], turns=0, removed_pieces=[])
    @board = board
    @pieces = pieces
    @removed_pieces = removed_pieces
    @color = color
    @enemy = nil
    @possible_moves_no_check = []
    @possible_moves_pre_check = []
    @turns = turns
  end

  MOVE_FORMAT = /[a-hA-H][1-8]\-[a-hA-H][1-8]/
  attr_accessor :board, :possible_moves_no_check, :pieces, :color, :possible_moves_pre_check,
                :enemy, :removed_pieces, :turns

  def initialize_pieces
    if @color == 'white'
      @pieces = 
      [
        WhitePawn.new(self, [0,6]),
        WhitePawn.new(self, [1,6]),
        WhitePawn.new(self, [2,6]),
        WhitePawn.new(self, [3,6]),
        WhitePawn.new(self, [4,6]),
        WhitePawn.new(self, [5,6]),
        WhitePawn.new(self, [6,6]),
        WhitePawn.new(self, [7,6]),
        Rook.new(self, [0,7]),
        Rook.new(self, [7,7]),
        Knight.new(self, [1,7]),
        Knight.new(self, [6,7]),
        Bishop.new(self, [2,7]),
        Bishop.new(self, [5,7]),
        Queen.new(self, [3,7]),
        King.new(self, [4,7])
      ]
    else
      @pieces = 
      [
      BlackPawn.new(self, [0,1]),
      BlackPawn.new(self, [1,1]),
      BlackPawn.new(self, [2,1]),
      BlackPawn.new(self, [3,1]),
      BlackPawn.new(self, [4,1]),
      BlackPawn.new(self, [5,1]),
      BlackPawn.new(self, [6,1]),
      BlackPawn.new(self, [7,1]),
      Rook.new(self, [0,0]),
      Rook.new(self, [7,0]),
      Knight.new(self, [1,0]),
      Knight.new(self, [6,0]),
      Bishop.new(self, [2,0]),
      Bishop.new(self, [5,0]),
      Queen.new(self, [3,0]),
      King.new(self, [4,0])
      ]
    end
  end

  def check?
    # Check if enemy's possible moves pre check can hit king
    king = @pieces.find {|piece| piece.instance_of? King }
    king_position = king.num_position
    enemy_moves = @enemy.total_moves_pre_check
    enemy_moves.each do |move|
      if move == king_position
        return true
      end
    end
    return false
  end

  def total_moves_no_check
    @possible_moves_no_check = []
    @pieces.each do |piece|
      piece.moves_no_check.each do |move|
        @possible_moves_no_check.push(move)
      end
    end
    @possible_moves_no_check
  end

  def total_moves_pre_check
    @possible_moves_pre_check = []
    @pieces.each do |piece|
      piece.moves_pre_check.each do |move|
        @possible_moves_pre_check.push(move)
      end
    end
    @possible_moves_pre_check
  end

  def choose_move
    move = []
    valid_move = false
    
    loop do
      # Make sure input is of the correct format first
      loop do 
        move = get_input
        if move == 'save'
          save_game(@board)
        elsif move == 'quit'
          abort("#{color.capitalize} concedes defeat!")
        end

        if valid_input?(move)
          break
        end
        puts "Wrong Format. Format ex. a2-b4"
      end

      # Match the current location to a piece
      start_loc = numberPosition(move[0..1])
      selected_piece = select_piece(start_loc)
      new_location = numberPosition(move[3..4])

      # Ensure move is valid
      if !selected_piece.moves_pre_check.include?(new_location)
        puts "Your piece can not move there."
      end

      if selected_piece.check_moves.include?(new_location)
        puts "This move would put you into check."
      end

      if selected_piece.moves_no_check.include?(new_location)
        move = [selected_piece.num_position, new_location]
        valid_move = true
        break
      end
    end
    return move
  end

  def get_input
    puts "#{@color.capitalize}, please enter in a move (ex. a2-b5) \nor enter 'save' or 'quit'"
    move = gets.chomp.downcase
    move
  end

  def valid_input?(input)
    input.match?(MOVE_FORMAT)
  end

  def play_turn
    # Loop through until player chooses valid move
    move = choose_move

    # Capture opponent if they occupied the space
    new_position = move[1]
    start_position = move[0]

    capture_opponent(new_position)

    # Move our piece to the new location
    move_piece(start_position, new_position)

    # Increment moves counter
    @turns += 1
    piece = select_piece(new_position)
    piece.moves += 1
    queen_pawn(piece)
  end

  def queen_pawn(moved_piece)
    if moved_piece.instance_of?(BlackPawn) || moved_piece.instance_of?(WhitePawn)
      if moved_piece.num_position[1] == 7 || moved_piece.num_position[1] == 0
        Queen.new(self, moved_piece.num_position)
        @pieces.delete_if {|piece| piece == moved_piece}
        @board.updateBoard
      end
    end
  end

  def capture_opponent(position)
    # Remove opponent's piece if move captures
    if occupied_enemy?(position)
      piece_to_remove = @enemy.select_piece(position)
      @enemy.removed_pieces << piece_to_remove
      @enemy.pieces.delete_if {|piece| piece == piece_to_remove}
      @board.updateBoard
    end
  end

  def reverse_capture
    # Reverse the capturing of a piece
    if !@enemy.removed_pieces.empty?
      @enemy.pieces << @enemy.removed_pieces.pop
    end
  end

  def print_pieces
    puts "#{@color.capitalize}'s pieces:"
    @pieces.each {|piece| puts "#{piece}: #{piece.num_position}" }
    print "\n"
  end

  def print_removed_pieces
    puts "#{@color.capitalize}'s REMOVED pieces:"
    unless @removed_pieces.empty?
      @removed_pieces.each {|piece| puts "#{piece}: #{piece.num_position}" }
    end
    print "\n"
  end

  def print_removed_symbols
    print "#{@color.capitalize}: "
    unless @removed_pieces.empty?
      @removed_pieces.each {|piece| print "#{piece.symbol}" }
    end
    print "\n"
  end

  def move_piece(start_location, end_location)
    # Move piece to new spot on board and update board
    selected_piece = select_piece(start_location)

    # Set selected piece's location to the end location
    selected_piece.num_position = end_location
    @board.updateBoard
  end

  def occupied_self?(position)
    self_loc_array = @pieces.map {|piece| piece.num_position }
    self_loc_array.include?(position)
  end

  def occupied_enemy?(position)
    enemy_loc_array = @enemy.pieces.map {|piece| piece.num_position }
    enemy_loc_array.include?(position)
  end

  def select_piece(position)
    if occupied_self?(position)
      selected_piece = @pieces.find {|piece| piece.num_position == position }
      return selected_piece
    else
      puts "Can't select enemy's piece."
      return
    end
  end

end
