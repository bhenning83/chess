require_relative 'playable'
require_relative 'game'
require_relative 'clearable'

class Bishop < Game
  include Playable
  include Clearable
  attr_accessor :pos, :board
  
  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
  end

  def valid?(new_spot)
    horz = (new_spot[0] - @pos[0]).abs
    vert = (new_spot[1] - @pos[1]).abs
    return true if horz == vert
    false
  end
  
end
game = Game.new
bishop = Bishop.new([5, 5], 'black', game.board)
game.board[2][2] = Bishop.new([2, 2], 'white', game.board)
puts bishop.valid?([3, 3])
puts bishop.valid?([5, 1])
puts bishop.clear?([1, 6])
puts bishop.clear?([1, 1])
