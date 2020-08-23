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
    if new_spot[0] == pos[0]
      clear_v?(new_spot) 
    elsif new_spot[1] == pos[1]
      clear_h?(new_spot) 
    elsif new_spot[1] > pos[1]
      clear_du?(new_spot)
    elsif new_spot[1] < pos[1]
      clear_dd?(new_spot)
    end
  end

  def clear_du?(new_spot)
    current = pos.dup
    until board[current[0]].nil? || board[current[1]].nil? || board[current[1]][current[0]] != ' - '
      if new_spot[0] > current[0] #moving up and right
        current[0] += 1; current[1] += 1
        return true if current == new_spot
      else #moving up and left
        current[0] -= 1; current[1] += 1
        return true if current == new_spot
      end
    end
    false
  end

  def clear_dd?(new_spot)
    current = pos.dup
    until board[current[0]].nil? || board[current[1]].nil? || board[current[1]][current[0]] != ' - '
      if new_spot[0] > current[0] #moving down and right
        current[0] += 1; current[1] -= 1
        return true if current == new_spot
      else #moving down and left
        current[0] -= 1; current[1] -= 1
        return true if current == new_spot
      end
    end
    false
  end

  def clear_v?(new_spot)
    current = pos.dup
    until board[current[0]].nil? || board[current[1]].nil? || board[current[1]][current[0]] != ' - '
      if new_spot[1] > current[1] #moving up
        current[1] += 1
        return true if current == new_spot
      else #moving down
        current[1] -= 1
        return true if current == new_spot
      end
    end
    false
  end

  def clear_h?(new_spot)
    current = pos.dup
    until board[current[0]].nil? || board[current[1]].nil? || board[current[1]][current[0]] != ' - '
      if new_spot[0] > current[0] #moving right
        current[0] += 1
        return true if current == new_spot
      else  #moving left
        current[0] -= 1
        return true if current == new_spot
      end
    end
    false
  end

end
game = Game.new
queen = Queen.new([5, 5], 'black', game.board)
game.board[2][2] = Queen.new([2, 2], 'black', game.board)
puts queen.clear?([1, 1])
puts queen.clear?([5, 0])