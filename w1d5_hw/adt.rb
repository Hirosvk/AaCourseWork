class Stack
  def initialize
    @stack = []
  end

  def add(el)
    @stack << el
  end

  def remove
    @stack.pop
  end

  def show
    @stack.dup
  end
end

class Queue
  def initialize
    @queue = []
  end

  def enqueue(el)
    @queue.unshift(el)
  end

  def dequeue
    @stack.shift
  end

  def show
    @queue.dup
  end
end

class Map

  def initialize
    @map = []
  end

  def assign(key, value)
    @map << [key, value]
  end

  def lookup(key)
    (_, value) = @map.find { |el| el[1] if el[0] == key }
    value
  end

  def remove(key)
    @map.delete_if { |el| el[0] == key }
  end

  def show
    @map.each { |el| puts "#{el[0]} => #{el[1]}" }
  end

end
