# create a board
# write move method for each piece
#   each piece will need to know all of it's possible moves
#     After each move, every piece must see if the opposing king is in it's valid, clear path
#       if the king is in check, loop through each possible move of each remaining piece on defensive team
#         at each possible defensive move, check every possible offensive move from every offensive piece
#         if king is still in check, move to next possible defensive move on king's side
#         break if king is never in check after checking every offensive move against a single defensive move
#         declare checkmate if all possible defensive moves on king's side are exhausted and king remains in check
# all game pieces can overtake opponent in their legal path, except pawns
# players will have to first input the coord of the piece they want to move
#   each player will need a piece_log
#   cycle throught eh piece_log to find the piece at the matching coordinate
#   assign that piece at that coordinate to an instance variable
#   get user input on where to move it to
#   check if it's valid
#   change coordinate of the piece

require_relative 'playable'

class Game
  include Playable
  attr_accessor :board

  def initialize
    @board = make_board
  end
end
