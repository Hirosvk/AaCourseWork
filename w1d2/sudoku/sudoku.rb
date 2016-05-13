require "colorize"
require "byebug"

class Tile
  attr_accessor :num, :given

  def initialize(num, given = false)
    @num = num
    @given = given
  end

  def to_s
    @given ? @num.to_s.colorize(:red) : @num.to_s
  end

  def guessed?
    @num > 0 || @given
  end

end

class Board
  attr_accessor :grid
  def initialize(grid = nil)
    @grid = grid
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, value)
    @grid[row][col] = value
  end

  def guessed?(row, col)
    self[row, col].guessed?
  end

  def given?(row, col)
    self[row, col].given
  end

  def load_solution!
    @grid = Board.populate_with("sudoku1-solved.txt")
  end

  def self.from_file(file_name = "sudoku1.txt")#factory method
    Board.new(Board.populate_with(file_name))
  end

  def self.populate_with(file_name)
    numbers = []
    File.open(file_name).each_char {|num| numbers << num.to_i unless num == "\n"}
    grid = Array.new(9) {Array.new(9)}
    9.times do |x|
      9.times do |y|
        new_num = numbers.shift
        grid[x][y] = Tile.new(new_num, new_num != 0)
      end
    end
    grid
  end


  def render
    puts "+ " + (0..8).to_a.join(" ")
    @grid.each_with_index do |row, i|
      puts i % 3 == 0 ? "-" * 20 : " " * 20
      print i.to_s
      row.each_with_index do |tile, j|
        print j % 3 == 0 ? "|" : " "
        print tile.to_s
      end
      print "\n"
    end
    self
  end


  def update_board(pos, num_guess)
    if self[*pos].num > 0
      puts "Changing the value from '#{self[*pos].num}' to '#{num_guess}'."
    else
      puts "Marking the tile with '#{num_guess.to_s}.'"
    end
    self[*pos].num = num_guess
  end


  def solved?
    @grid.each {|row| return false unless row_solved?(row)}
    9.times { |col_num| return false unless col_solved?(col_num)}
    [0,3,6].each do |i|
      [0,3,6].each do |j|
        return false unless square_solved?(i,j)
      end
    end
    true
  end

  def row_solved?(row)
    row.map{|tile| tile.num}.sort == (1..9).to_a
    #debugger
  end

  def col_solved?(col_num)
    column = @grid.map { |row| row[col_num].num }
    column.sort == (1..9).to_a
    #debugger
  end

  def square_solved?(*rt_corner)
    square_arr = []
    3.times do |i|
      3.times do |j|
        square_arr << @grid[rt_corner[0]+i][rt_corner[1]+j].num
      end
    end
    square_arr.sort == (1..9).to_a
  end

end
