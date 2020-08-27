require_relative 'playable'

class King
  include Playable
  attr_accessor :pos, :board, :poss_moves, :symbol
  attr_reader :color

  def initialize(pos, color, board, symbol)
    @pos = pos
    @color = color
    @board = board
    @moves = [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]]
    @poss_moves = []
    @symbol = symbol
    find_poss_moves
  end

  def clear?(new_spot)
    return true if poss_moves.include?(new_spot)
    false
  end

  def valid?(new_spot)
    new_spot.each_index do |i|
      diff = (new_spot[i] - pos[i]).abs
      return true if diff == 1
    end
    false
  end

  def find_poss_moves(poss_pos = [])
    @moves.each do |move|
      pos.each_index do |i|
        poss_pos[i] = pos[i] + move[i]
      end
      next unless on_board?(poss_pos)
      poss_moves << poss_pos.dup
    end
  end

  def on_board?(poss_pos)
    poss_pos.each do |value|
      return false if value > 7 || value < 0
    end
    true
  end
end