require_relative 'playable'
require_relative 'game'
class King < Game
  include Playable
  attr_accessor :pos, :board

  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
  end

  def valid?(new_spot)
    return false if new_spot[0] != pos[0]
    if color == 'white'
      return true if new_spot[1] - pos[1] == 1
    else 
      return true if pos[1] - new_spot[1] == 1
    end
    false
  end
end