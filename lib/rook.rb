require_relative 'playable'
require_relative 'game'
require_relative 'king'
require 'pry'

class Rook < Game
  include Playable
  attr_accessor :pos, :board, :values

  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
    @values = []
  end

  def valid?(new_spot)
    return true if new_spot[0] == @pos[0]
    return true if new_spot[1] == @pos[1]
    false
  end
  
  def clear?(new_spot)
    if new_spot[0] == @pos[0] #if rook is moving vertically
      endpoints(new_spot, 1)
      for i in values[0]...values[1] 
          return false unless board[i][pos[0]] == ' - '
      end
    elsif new_spot[1] == @pos[1] #if rook is moving horizontally
      endpoints(new_spot, 0)
      for i in values[0]...values[1]
        return false unless board[pos[1]][i] == ' - '
      end
    end
    true
  end

  def endpoints(new_spot, idx)
    values << new_spot[idx]
    values << pos[idx]
    values.sort!
  end
end

  game = Game.new
  rook = Rook.new([7, 5], 'black', game.board)
  game.board[5][5] = King.new([5, 5], 'black', game.board)
  puts rook.clear?([1, 5])
  p game.display_board