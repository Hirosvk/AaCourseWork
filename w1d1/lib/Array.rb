class Array

  def my_flatten
    results = []
    self.each do |el|
      if el.class == Array
        results = results + el.my_flatten
      else
        results << el
      end
    end
    results
  end


  def my_zip(*args)
    array = args
    results = Array.new(self.length) {Array.new(0)}
    self.each_with_index do |el, idx|
      results[idx] << el
      array.each do |ary|
        results[idx] << ary[idx]
      end
    end
    results
  end

  def my_rotate(shift = 1)
    results = Array.new(self.length)
    self.each_with_index do |el, idx|
      results[(idx - shift)%self.length] = el
    end
    results
  end

  def my_join(separator = "")
    results = ""
    self.each_with_index do |el, idx|
      results << el
      results << separator unless idx + 1 == self.length
    end
    results
  end

  def my_reverse
    result = []
    (self.length - 1).downto(0) do |i|
      result << self[i]
    end
    result
  end
end
