require_relative 'playable'
class Bishop
  include Playable
  attr_accessor :pos,
  
  def initialize(pos, color)
    @pos = pos
    @color = color
  end

  def valid?(new_spot)
    horz = (new_spot[0] - @pos[0]).abs
    vert = (new_spot[1] - @pos[1]).abs
    return true if horz == vert
    false
  end
  
  def clear?(new_spot, pot_pos = [])
    current = pos.dup
    until @board[current[0]].nil? || @board[current[1]].nil?
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

bishop = Bishop.new([5, 5], 'black')
puts bishop.valid?([3, 3])
puts bishop.valid?([5, 1])
puts bishop.clear?([1, 6])
puts bishop.clear?([1, 1])
