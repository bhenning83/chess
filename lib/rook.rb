require_relative 'playable'
class Rook
  include Playable
  attr_accessor :pos

  def initialize(pos, color)
    @pos = pos
    @color = color
  end

  def valid?(new_spot)
    return true if new_spot[0] == @pos[0]
    return true if new_spot[1] == @pos[1]
    false
  end
  
  def clear?(new_spot)
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

  rook = Rook.new([1, 1], 'black')
  puts rook.valid?([3, 4])
  puts rook.valid?([5, 1])
  puts rook.open?([1, 6])
  puts rook.open?([5, 2])