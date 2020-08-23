require_relative 'playable'
require_relative 'game'
game = Game.new
class Bishop < Game
  include Playable
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
  
  def clear?(new_spot)
    current = pos.dup
    until board[current[0]].nil? || board[current[1]].nil? || board[current[1]][current[0]] != ' - '
      if new_spot[0] > current[0] && new_spot[1] > current[1] #moving up and right
        current[0] += 1; current[1] += 1
        return true if current == new_spot
      elsif new_spot[0] > current[0] && new_spot[1] < current[1] #moving down and right
        current[0] += 1; current[1] -= 1
        return true if current == new_spot
      elsif new_spot[0] < current[0] && new_spot[1] < current[1] #moving down and left
        current[0] -= 1; current[1] -= 1
        return true if current == new_spot
      else new_spot[0] < current[0] && new_spot[1] > current[1] #moving up and left
        current[0] -= 1; current[1] += 1
        return true if current == new_spot
      end
    end
    false
  end


end
game = Game.new
bishop = Bishop.new([5, 5], 'black', game.board)
#game.board[2][2] = Bishop.new([2, 2], 'white', game.board)
puts bishop.valid?([3, 3])
puts bishop.valid?([5, 1])
puts bishop.clear?([1, 6])
puts bishop.clear?([1, 1])
