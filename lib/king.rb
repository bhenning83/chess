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
    new_spot.each_index do |i|
      diff = (new_spot[i] - pos[i]).abs
      return true if diff == 1
    end
    false
  end
end

game = Game.new
king = King.new([4, 1], 'black', game.board)
p king.valid?([5, 1])
p king.valid?([6, 4])
p king.valid?([4, 2])