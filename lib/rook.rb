require_relative 'playable'
require_relative 'game'
require_relative 'king'
require 'pry'

class Rook < Game
  include Playable
  attr_accessor :pos, :board

  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
  end

  def valid?(new_spot)
    return true if new_spot[0] == @pos[0]
    return true if new_spot[1] == @pos[1]
    false
  end
  
  def clear?(new_spot)
    if new_spot[0] == @pos[0]
      for i in @pos[1]...new_spot[1] #if rook is moving vertically
        binding.pry
        return false unless board[0][i] == ' - '
      end
    elsif new_spot[1] == @pos[1] #if rook is moving horizontally
      for i in @pos[0]...new_spot[0]
        return false unless board[i][0] == ' - '
      end
    end
    true
  end
end

  game = Game.new
  rook = Rook.new([1, 7], 'black', game.board)
  king = King.new([1, 5], 'black', game.board)
  puts rook.clear?([1, 2])