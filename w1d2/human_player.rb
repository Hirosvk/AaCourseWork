class HumanPlayer

  def initialize
    @name
  end

  def make_guess
    gets.chomp.split(",").map(&:to_i)
  end

  def display(board)
    board.display
  end

  def receive_revealed_card(card, pos)
  end

  def receive_match(pos_one, pos_two)
  end

end
