require_relative 'playable'
require_relative 'game'
require_relative 'king'
require 'pry'

class Pawn < Game
  include Playable
  attr_accessor :pos, :board, :color

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

  def check?
    if color == 'white'
      binding.pry
      return if pos[1] == 7
      return true if board[pos[1] - 1][pos[0] + 1].is_a?(King)
      return true if board[pos[1] - 1][pos[0] - 1].is_a?(King)
    else 
      return if pos[1] == 0
      return true if board[pos[1] + 1][pos[0] + 1].is_a?(King)
      return true if board[pos[1] + 1][pos[0] - 1].is_a?(King)
    end
    false
  end
end

game = Game.new
pawn = Pawn.new([2,7], 'white', game.board)
p pawn.valid?([2, 8])
p pawn.valid?([5, 0])
game.board[7][2] = King.new('black', [3, 8], game.board)
p pawn.check?
p game.board