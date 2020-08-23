require_relative 'playable'
require_relative 'game'
require 'pry'

class Queen < Game
  include Playable
  attr_accessor :pos, :board, :values
  
  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
    @values = values
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
        return true if current == new_spot
        current[0] -= 1; current[1] -= 1
        binding.pry
      else new_spot[0] < current[0] && new_spot[1] > current[1] #moving up and left
        current[0] -= 1; current[1] += 1
        return true if current == new_spot
      end
    end
    binding.pry
    false
  end

  def clear_vh?(new_spot)
    if new_spot[0] == @pos[0] #if queen is moving vertically
      endpoints(new_spot, 1)
      for i in values[0]...values[1] 
          return false unless board[i][pos[0]] == ' - '
      end
    elsif new_spot[1] == @pos[1] #if queen is moving horizontally
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
queen = Queen.new([5, 5], 'black', game.board)
game.board[2][2] = Queen.new([2, 2], 'black', game.board)
puts queen.clear?([1, 1])