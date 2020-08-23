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