require "colorize"
require "byebug"

class Tile
  attr_accessor :num, :given

  def initialize(num)
    @num = num
    @given = false
  end

  def to_s
    @given ? @num.to_s.colorize(:red) : @num.to_s
  end


end

class Board
  attr_accessor :grid
  def initialize(grid = nil)
    grid ||= Array.new(9) {Array.new(9)}
    @grid = grid
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, value)
    @grid[row][col] = value
  end

  def load_solution!
    numbers = []
    File.open("sudoku1-solved.txt").each_char {|num| numbers << num.to_i unless num == "\n"}
    grid = Array.new(9) {Array.new(9)}
    9.times do |idx1|
      9.times do |idx2|
        new_num = numbers.shift
        grid[idx1][idx2] = Tile.new(new_num)
        grid[idx1][idx2].given = true unless new_num == 0
      end
    end
    @grid = grid
  end

  def self.from_file(file_name = nil)
    file_name ||= "sudoku1.txt"
    numbers = []
    File.open(file_name).each_char {|num| numbers << num.to_i unless num == "\n"}
    grid = Array.new(9) {Array.new(9)}
    9.times do |idx1|
      9.times do |idx2|
        new_num = numbers.shift
        grid[idx1][idx2] = Tile.new(new_num)
        grid[idx1][idx2].given = true unless new_num == 0
      end
    end
    Board.new(grid)
  end

  def display
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
  end

  def get_guess
    while true
      print "\nEnter the position(row, col): "
      pos = gets.chomp.split(",").map(&:to_i)
      print "\nEnter the number: "
      num_guess = gets.to_i
      break if valid_entry?(pos, num_guess)
    end
    update(pos, num_guess)
  end

  def update(pos, num_guess)
    if self[*pos].num > 0
      puts "Changing the value from '#{self[*pos].num}' to '#{num_guess}'."
    else
      puts "Marking the tile with '#{num_guess.to_s}.'"
    end
    self[*pos].num = num_guess
  end

  def valid_entry?(pos, num_guess)
    if num_guess > 9 || num_guess < 1
      puts "The number has to be between 1 and 9."
      return false
    elsif self[*pos].given
      puts "You cannot change that tile."
      return false
    end
    true
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
        #debugger
        square_arr << @grid[rt_corner[0]+i][rt_corner[1]+j].num
      end
    end
    square_arr.sort == (1..9).to_a
    #debugger
  end

end
