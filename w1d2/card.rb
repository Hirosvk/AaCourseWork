class Card
  attr_reader :value, :face_up

  def initialize(value)
    @face_up = false
    @value = value
  end

  def display
    @face_up ? @value.to_s : "X"
  end

  def hide
    @face_up = false
  end

  def reveal
    @face_up = true
  end

  def ==(other_card)
    @value == other_card.value
  end



end
