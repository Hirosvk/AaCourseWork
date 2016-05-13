class Tile
  attr_accessor :num, :given

  def initialize(num, given = false)
    @num = num
    @given = given
  end

  def to_s
    if @given
      @num.to_s.colorize(:red)
    elsif @num == 0
      "\s"
    else
      @num.to_s
    end
  end

  def guessed?
    @num > 0
  end

end
