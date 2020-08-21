module Playable
  def make_board
    hash = {}
    (0..7).each do |i|
      hash[i] = Array.new(8, ' - ')
    end
    hash
  end

  def display_board
    board.each do |_key, value|
      puts
      value.each do |chip|
        print chip
      end
    end
    puts
  end
end
