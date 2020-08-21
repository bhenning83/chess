require_relative 'playable'
require_relative 'game'
class Queen < Game
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
    return true if horz == vert #if moving diagnolly
    return true if new_spot[0] == @pos[0] #if moving vertically
    return true if new_spot[1] == @pos[1] #if moving horizontally
    false
  end

  def clear?(new_spot)
    return true if clear_diag?(new_spot) || clear_vh?(new_spot)
    false
  end
  
  def clear_diag?(new_spot)
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

  def clear_vh?(new_spot)
    if new_spot[0] == @pos[0]
      for i in new_spot[1]..@pos[1] #if rook is moving vertically
        return false unless board[0][i] == ' - '
      end
    elsif new_spot[1] == @pos[1] #if rook is moving horizontally
      for i in new_spot[0]..@pos[0]
        return false unless board[i][0] == ' - '
      end
    end
    true
  end


end
game = Game.new
queen = Queen.new([5, 5], 'black', game.board)
puts queen.valid?([3, 3])
puts queen.valid?([5, 1])
puts queen.clear?([1, 6])
puts queen.valid?([1, 6])
puts queen.clear?([1, 1])