require_relative 'playable'
class Bishop
  include Playable
  attr_accessor :pos, :moves
  
  def initialize(pos, color)
    @pos = pos
    @color = color
    @moves = [[1, 1], [-1, 1], [-1, -1], [1, -1]]
  end

  def valid?(new_spot)
    horz = (new_spot[0] - @pos[0]).abs
    vert = (new_spot[1] - @pos[1]).abs
    return true if horz == vert
    false
  end
  
  def clear?(new_spot, pot_move = [])
    moves.each do |move|
      pos.each_index do |i|
        pot_move[i] = current[i] + move[i]
      end
      return false unless board[pot_move[1]][pot_move[0]] == ' - '
    end
    true
  end
end