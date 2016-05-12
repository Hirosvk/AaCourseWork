require 'byebug'

class Board
  attr_reader :grid, :num_pairs
  DIFFICULTY = { easy: 2, medium: 4, hard: 6}

  def initialize(x = 4)
    @grid = Array.new(x) {Array.new(x)}
    @num_pairs = (x ** 2) / 2
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, card)
    @grid[row][col] = card
  end

  def length
    @grid.length
  end

  def populate_grid
    letters = (:A..:Z).to_a
    card_values = letters[0...@num_pairs] * 2
    shuffled = card_values.shuffle
    debugger
    @grid.each_index do |i|
      @grid[i].each_index do |j|
        self[i, j] = Card.new(shuffled.pop)
      end
    end
  end

  def display
    print '+ ' + (0...length).to_a.join(' ')
    @grid.each_with_index do |row, i|
      print "\n" + i.to_s + ' '
      row.each do |card|
        print card.display + " "
      end
    end
    puts "\n"
  end

  def reveal(pos)
    self[*pos].reveal
    self[*pos].value
  end

  def revealed?(pos)
    self[*pos].face_up
  end

  def hide(pos)
    self[*pos].hide
  end

  def won?
    @grid.flatten.none? {|card| card.face_up == false }
  end


end
