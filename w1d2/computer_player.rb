class ComputerPlayer
  attr_reader :known_cards, :dont_pick, :revealed_card_value, :board_length

  def initialize
    @known_cards = {}
    @dont_pick = []
    @revealed_card_value
    @revealed_card_pos
    @board_length
  end

  def display(board)
    board.display
    @board_length = board.length
  end

  def make_guess
    if first_guess?
      if known_pair?
        pos = @known_cards.key(known_pair?)
        @known_cards.delete(pos)
        return pos
      end
    else
      if has_match?
        pos = find_match
        @known_cards.delete(pos)
        return pos
      end
    end

    return random_move
  end

  def receive_revealed_card(card, pos)
    @known_cards[pos] = card.value
    process_revealed_card(card, pos)
  end

  def first_guess?
    @revealed_card_value.nil?
  end

  def known_pair?
    letters = @known_cards.values
    letters.find { |letter| letters.count(letter) > 1 }
  end

  def random_move
    pos = [rand(0...@board_length), rand(0...@board_length)]
    while known_card?(pos)
      pos = [rand(0...@board_length), rand(0...@board_length)]
    end

    pos
  end

  def known_card?(pos)
    @dont_pick.include?(pos) || @known_cards.keys.include?(pos)
  end

  def has_match?
    if @known_cards.has_value?(@revealed_card_value)
      pos = find_match
      return pos != @revealed_card_pos
    end

    false
  end

  def find_match
    @known_cards.key(@revealed_card_value)
  end

  def process_revealed_card(card, pos)
    @revealed_card_value ? @revealed_card_value = nil : @revealed_card_value = card.value
    @revealed_card_pos = pos
  end

  def receive_match(pos_one, pos_two)
    @dont_pick << pos_one << pos_two
    @known_cards.delete(pos_one)
    @known_cards.delete(pos_two)
  end

end
