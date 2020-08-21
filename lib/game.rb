# create a board
# write move method for each piece
#   each piece will need to know all of it's possible moves
#     After each move, every piece must loop through all its possible moves to see if king is in check
#       if the king is in check, loop through each possible move of each remaining piece on king's team
#         at each possible move, check every possible move from every piece on opponent's side
#         if king is still in check, move to next possible move on king's side
#         break if king is never in check after checking a single possible move
#         declare checkmate if all possible moves on king's side are exhausted and king remains in check
# all game pieces can overtake opponent in their legal path, except pawns
# players will have to first input the coord of the piece they want to move
#   each player will need a piece_log
#   cycle throught eh piece_log to find the piece at the matching coordinate
#   assign that piece at that coordinate to an instance variable
#   get user input on where to move it to
#   check if it's valid
#   change coordinate of the piece

class Game
  attr_accessor :board
  def initialize
    @board = make_board
  end
  
  def make_board
    hash = {}
    (0..7).each do |i|
      hash[i] = Array.new(8, ' - ')
    end
    hash
  end

  def display_board
    board.each do |_key, value|
      puts
      value.each do |chip|
        print chip
      end
    end
    puts
  end
end

game = Game.new
game.display_board