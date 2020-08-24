require_relative 'playable'
require_relative 'game'
class King < Game
  include Playable
  attr_accessor :pos, :board, :poss_moves

  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
    @moves = [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]]
    @poss_moves = []
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

game = Game.new
king = King.new([1, 0], 'white', game.board)
king.find_poss_moves
p king.poss_moves
