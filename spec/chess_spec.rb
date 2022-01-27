# require_relative '../lib/main'
# require_relative '../lib/game'
# require_relative '../lib/board'
# require_relative '../lib/player'
# require_relative '../lib/piece'
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

# # PIECES FILE
# describe Piece do
  
# end

# describe Pawn do
#   describe '#possibleMoves' do
#     context 'when not blocked' do
#       it 'returns two spaces and existing pawn as mover' do

#       end
#   end
# end

# describe Rook do
  
# end

# describe Knight do
  
# end

# describe Bishop do
  
# end

# describe Queen do
  
# end

# describe King do
  
# end

describe Space do
  describe '#numberPosition' do
    context 'when given a character position' do
      it 'returns the number position' do
        num_position = numberPosition('a2')
        expect(num_position).to eq([0,6])
      end
    end
  end

  describe '#charPosition' do
    context 'when given a number position' do
      it 'returns the character position' do
        char_position = charPosition([0,6])
        expect(char_position).to eq('a2')
      end
    end
  end
end
