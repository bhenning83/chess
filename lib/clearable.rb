require 'pry'
module Clearable
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
    return clear_ur?(new_spot) if new_spot[0] > pos[0]
    return clear_ul?(new_spot) if new_spot[0] < pos[0]
  end

  def clear_dd?(new_spot)
    return clear_dr?(new_spot) if new_spot[0] > pos[0]
    return clear_dl?(new_spot) if new_spot[0] < pos[0]
  end

  def clear_ur?(new_spot) #moving up and right
    current = pos.dup
    diff = new_spot[0] - pos[0]
    return true if diff == 1
    (diff - 1).times do
      current[0] += 1; current[1] += 1
      return false unless board[current[1]][current[0]] == ' - '
    end
    true
  end

  def clear_ul?(new_spot) #moving up and left
    current = pos.dup
    diff = pos[0] - new_spot[0]
    return true if diff == 1
    (diff - 1).times do
      current[0] -= 1; current[1] += 1
      return false unless board[current[1]][current[0]] == ' - '
    end
    true
  end

  def clear_dr?(new_spot) #moving down and right
    current = pos.dup
    diff = new_spot[0] - pos[0]
    return true if diff == 1
    (diff - 1).times do
      current[0] += 1; current[1] -= 1
      return false unless board[current[1]][current[0]] == ' - '
    end
    true
  end

  def clear_dl?(new_spot) #moving down and left
    current = pos.dup
    diff = pos[0] - new_spot[0]
    return true if diff == 1
    (diff - 1).times do
      current[0] -= 1; current[1] -= 1
      return false unless board[current[1]][current[0]] == ' - '
    end
    true
  end

  def clear_v?(new_spot)
    if new_spot[1] > pos[1] #moving up
      (pos[1] + 1...new_spot[1]).each do |i|
        return false if board[i][pos[0]] != ' - '
      end
    else #moving down
      (new_spot[1]...pos[1] - 1).each do |i|
        return false if board[i][pos[0]] != ' - '
      end
    end
    true
  end

  def clear_h?(new_spot)
    if new_spot[0] > pos[0] #moving right
      (pos[0] + 1...new_spot[0]).each do |i|
        return false if board[pos[1]][i] != ' - '
      end
    else #moving left
      (new_spot[0]...pos[0] - 1).each do |i|
        return false if board[pos[1]][i] != ' - '
      end
    end
    true
  end
end