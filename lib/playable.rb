module Playable
  def make_board
    hash = {}
    (0..7).each do |i|
      hash[i] = Array.new(8, ' - ')
    end
    reverse_hash = Hash[hash.to_a.reverse]
  end

  def display_board
    board.each do |key, value|
      puts
      print "#{key + 1} "
      value.each do |piece|
        piece == ' - ' ? (print piece) : (print piece.symbol)
      end
    end
    puts 
    puts "   A  B  C  D  E  F  G  H\n\n"
  end
end
