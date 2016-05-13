class Player

  def prompt
  end

  def get_guess
    print "\nEnter the position(row, col): "
    pos = gets.chomp.split(",").map(&:to_i)
    print "\nEnter the number: "
    num_guess = gets.to_i
    [pos, num_guess]
  end

  def process_board(board)
  end

end


class AiPlayer

  def initialize
    @initial_board = nil
    @current_board = nil
    @tracker = [0,0]
    @bad_patterns #= Arrays of unworkable number combinations so that
    #it doesn't repeat the same pattern.
  end

  def process_board(board)
    @initial_board ||= board
    @current_board = @initial_board
  end

  def get_guess
    # reset_board if I_have_seen_this_pattern?
    while @current_board.guessed?(@tracker)
      # puts "This has been guessed => #{@tracker.to_s}."
      advance_tracker
    end
    number_guess = available_number(@tracker)

    # if number_guess.nil?
    #   reset_board
    #   return nil
    # end

    [@tracker, number_guess]
  end

  def I_seen_this_pattern?
    @bad_patterns.include?(@current_board.flatten.map(&:num))
  end

  def reset_board
    @bad_patterns << @current_board.flatten.map(&:num)
    @current_board = @initial_board
    @tracker = [0,0]
  end

  def advance_tracker
    @tracker[1] = (@tracker[1] + 1) % 9
    @tracker[0] = (@tracker[0] + 1) % 9 if @tracker[1] == 0
  end

  def confict?(guess)
    #based on the current status of the board, does this move
    #contradicts with the rules?
  end

  def available_number(pos)
    5
    #returns a number that doesn't conflict with the rules.
  end

  def available_numbers_row
  end

  def available_numbers_col
  end

  def available_numbers_square
  end

end
