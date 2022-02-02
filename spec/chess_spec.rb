require_relative '../lib/main'
require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'
require_relative '../lib/piece'
require_relative '../lib/space'

# # GAME FILE
# describe Game do
  
# end
# # BOARD FILE
# describe Board do
#   describe 'onBoard?' do
#     context 'when the position is not on the board' do
#       it 'returns false' do
#         # test
#       end
#     end
    
#     context 'when the position is on the board' do
#       it 'returns true' do
#         # test
#       end
#     end
#   end

#   describe '#occupied_enemy?' do
#     context 'when the position is occupied by the enemy' do
#       it 'returns true' do
#         # test
#       end
#     end

#     context 'when the position is not occupied by the enemy' do
#       it 'returns false' do
#         # test
#       end
#     end
#   end

#   describe '#occupied_self?' do
#     context 'when it is not occupied by yourself' do
#       it 'returns false' do
#         # test
#       end
#     end

#     context 'when it is occupied by yourself' do
#       it 'returns true' do
#         # test
#       end
#     end
#   end
# end

# # PLAYER FILE
# describe Player do
#   describe '#check?' do
#     context 'when active player is in check on board' do
#       it 'returns true' do
#         # test
#       end
#     end

#     context 'when active player is not in check' do
#       it 'returns false' do
#         # test
#       end
#     end
#   end

#   describe '#possibleMoves' do
#     context 'when the game starts' do
#       it 'returns array of all possible moves' do
#         # test
#       end
#     end

#     context 'when the game is in the middle' do
#       it 'returns small array of all possible moves' do
#         # test
#       end
#     end

#     context 'when the current player is in checkmate' do
#       it 'returns an empty array' do
#         # test
#       end
#     end
#   end

#   describe '#select_piece' do
#     context 'when a piece exists at that spot' do
#       it 'returns the selected piece object' do
#         # test
#       end
#     end

#     context 'when a piece does not exist at that spot' do
#       it 'returns an empty hash' do
#         # test
#       end
#     end
#   end

#   describe '#choose_move' do
#     context 'when the chose move is valid' do
#       it 'returns the valid move in piece, location format' do
#         # test
#       end
#     end

#     context 'when the move is not valid, then valid' do
#       it 'requests the move twice before returning the correct move' do
#         # test
#       end
#     end
#   end

#   describe '#move' do
#     # Don't need to test since just a script
#   end

#   describe '#capture_opponent' do
#     context 'when there is an opponent in the space' do
#       it 'removes the opponents piece from their pieces hash' do
#         # test
#       end
#     end

#     context 'when there is no opponent in the space' do
#       it 'does nothing' do
#         # test
#       end
#     end
#   end

#   describe '#move_piece' do
#     context 'when the move is legitimate' do
#       it 'updates the board with the pieces new location and removes the old' do
#         # test
#       end
#     end
#   end
# end

# PIECES FILE
# describe Piece do
  
# end

describe WhitePawn do
  describe '#moves_pre_check' do
    context 'when not blocked and no enemies to capture' do
      fake_board = Board.new
      pawn = WhitePawn.new(fake_board.white, [1,6], "\u265f", 'white')
      it 'returns one space and existing pawn as mover' do
        expect(pawn.moves_pre_check[0]).to eq([1,5])
      end
    end

    context 'when not blocked and straight would put in check' do
      fake_board = Board.new
      king = King.new(fake_board.white, [4,5], "\u265a", 'white')
      pawn = WhitePawn.new(fake_board.white, [3,4], "\u265f", 'white')
      enemy_bishop = Bishop.new(fake_board.black, [1,2], "\u2657", 'black')
      fake_board.updateBoard
      it 'returns one space and existing pawn as mover' do
        potential_moves = pawn.moves_pre_check
        expect(potential_moves).to eq([[3,3]])
      end
    end

    context 'when blocked by enemy' do
      fake_board = Board.new
      king = King.new(fake_board.white, [4,5], "\u265a", 'white')
      pawn = WhitePawn.new(fake_board.white, [3,4], "\u265f", 'white')
      enemy_bishop = Bishop.new(fake_board.black, [3,3], "\u2657", 'black')
      fake_board.updateBoard
      it 'returns empty array' do
        potential_moves = pawn.moves_pre_check
        expect(potential_moves).to eq([])
      end
    end

    context 'when blocked by self' do
      fake_board = Board.new
      king = King.new(fake_board.white, [4,5], "\u265a", 'white')
      pawn = WhitePawn.new(fake_board.white, [3,4], "\u265f", 'white')
      enemy_bishop = Bishop.new(fake_board.white, [3,3], "\u2657", 'white')
      fake_board.updateBoard
      it 'returns empty array' do
        potential_moves = pawn.moves_pre_check
        expect(potential_moves).to eq([])
      end
    end

    context 'when ahead is empty, and corners are occupied by enemy' do
      fake_board = Board.new
      king = King.new(fake_board.white, [4,5], "\u265a", 'white')
      pawn = WhitePawn.new(fake_board.white, [3,4], "\u265f", 'white')
      enemy_bishop = Bishop.new(fake_board.white, [2,3], "\u2657", 'white')
      enemy_bishop_2 = Bishop.new(fake_board.white, [4,3], "\u2657", 'white')
      fake_board.updateBoard
      fake_board.displayBoard
      it 'returns array with three moves' do
        potential_moves = pawn.moves_pre_check
        expect(potential_moves).to match_array([[2,3], [4,3], [3,3]])
      end
    end
  end

  describe '#moves_no_check' do
    context 'when not blocked' do
      it 'returns one space and existing pawn as mover' do

      end
    end

    context 'when not blocked but move would put in check' do
      it 'returns empty array' do

      end
    end
  end
end

# describe Rook do
  
# end

# describe Knight do
  
# end

describe Bishop do
  describe '#moves_pre_check' do
    context 'when board is completely open' do
      it 'returns all spaces in diagonals on board from space' do
        fake_board = Board.new
        bishop = Bishop.new(fake_board.white, [3,3], "\u265d", 'white') 
        move_array = bishop.moves_pre_check
        expect(move_array).to match_array([[0,0], [1,1], [2,2], [4,4], [5,5], [6,6], [7,7],
                                          [6,0], [5,1], [4,2], [2,4], [1,5], [0,6]])
      end
    end
  end
end

# describe Queen do
  
# end

describe King do
  
end

describe Space do
  describe '#numberPosition' do
    context 'when given a character position' do
      let(:num_test) { Class.new { extend Space } }
      it 'returns the number position' do
        num_position = num_test.numberPosition('a2')
        expect(num_position).to eq([0,6])
      end
    end
  end

  describe '#charPosition' do
    context 'when given a number position' do
      let(:char_test) { Class.new { extend Space } }
      it 'returns the character position' do
        char_position = char_test.charPosition([0,6])
        expect(char_position).to eq('a2')
      end
    end
  end
end
