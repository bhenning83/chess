require 'json'
require 'pry'

module Savable
  def to_json(*_args)
    JSON.dump({
                white_pieces: breakdown(@white_pieces),
                black_pieces: breakdown(@black_pieces)
              })
  end

  def breakdown(piece_list, hash = {})
    return if piece_list.nil?
    piece_list.each do |piece|
      hash[piece] = Hash.new
      piece.instance_variables.each do |var|
        next if var == :@board
        hash[piece][var] = piece.instance_variable_get var
      end
    end
    hash
  end

  def save
    puts 'Enter a name for your saved game.'
    save_name = gets.chomp
    stream = to_json
    File.open(@path + save_name, 'w') { |f| f.puts stream }
    puts 'Game saved. Do you want to quit your game? yes/no'
    if gets.chomp.downcase == 'yes'
      puts 'k bye'
      exit 
    end
  end

  def load
    puts 'What is the name of your saved game?'
    answer = gets.chomp
    save = File.read(@path + answer)
    data = JSON.parse(save)
    binding.pry
    @white_pieces = reassign(data['white_pieces'])
    @black_pieces = reassign(data['black_pieces'])
   
    @loaded = true
  end

  def reassign(hash)
    hash.each do |_name, values|
      values.each do |var, val|
        instance_variable_set var, val
      end
    end
  end

  def ask_to_load
    puts 'Do you want to start a new game or continue a saved game? new/load'
    return nil unless gets.chomp.strip.downcase == 'load'

    load
  end
end