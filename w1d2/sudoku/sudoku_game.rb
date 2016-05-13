require "./board.rb" #board loads tile class
require "./player.rb"

class Game
  attr_accessor :player
  attr_reader :board
  def initialize(board = Board.from_file, player = AiPlayer.new)
    @board = board
    @player = player
    @player.process_board(@board)
  end

  def play
    puts "Let's solve this puzzle!"
    until @board.solved?
      @player.process_board(@board.render)
      take_turn
      system("clear")
      sleep(3)
    end
    puts "You solved the puzzle!"
  end

  def take_turn
    pos, number = nil, nil
    until valid_entry?(pos, number)
      (pos, number) = @player.get_guess
    end
    @board.update_board(pos, number)
  end


  def valid_entry?(pos, num_guess)
    return false if pos == nil

    if out_of_range([1,9], num_guess)
      puts "The number has to be between 1 and 9."
      return false
    end

    if out_of_range([0,8], pos[0]) && out_of_range([0,8], pos[1])
      puts "positions need to be between 0 and 8."
      return false
    end

    if @board.given?(*pos)
      puts "You cannot change that number."
      return false
    end
    true
  end

  def out_of_range(range, num)
    num < range[0] || num > range[-1]
  end

end

Game.new.play
# Game.new.play
