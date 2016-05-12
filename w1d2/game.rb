require "./card.rb"
require "./board.rb"
require "./computer_player.rb"
require "./human_player.rb"

class Game
  attr_reader :board, :player

  def initialize(board = Board.new, player = ComputerPlayer.new)
    @board = board
    @player = player
  end

  def over?
    @board.won?
  end

  def render
    system("clear")
    @player.display(@board)
  end

  def get_guess
    puts "Guess the position: "
    pos = @player.make_guess
    until valid_move?(pos)
      puts "Choose a different card."
      pos = @player.make_guess
    end
    puts "First guess: #{pos}"
    pos
  end

  def play
    @board.populate_grid
    puts "Let's start a new game!"
    until over?
      process_guess
    end
    puts "You won!"
  end

  def process_guess
    render

    pair = []
    2.times do
      pos = get_guess
      @board.reveal(pos)
      @player.receive_revealed_card(@board[*pos], pos)
      pair << pos
      render
    end

    is_match?(pair)

    sleep(3)
  end

  def is_match?(pair)
    if @board[*pair[0]] == @board[*pair[1]]
      puts "It's a match!"
      @player.receive_match(pair[0], pair[1])
    else
      @board.hide(pair[0])
      @board.hide(pair[1])
      puts "No luck!"
    end
  end

  def valid_move?(pos)
    return false if @board[*pos].nil? || @board.revealed?(pos)
    true
  end



end
