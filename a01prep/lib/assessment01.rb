class Array
  def my_inject(accumulator = nil)
    accumulator ||= self.shift
    self.each do | el|
      accumulator = yield(accumulator, el)
    end
    accumulator
  end
end

def is_prime?(num)
  is_it = true
  i = 2
  while i < num
    if num % i == 0
      is_it = false

      break
    end
    i += 1
  end
  is_it
end

def primes(count)
  return [] if count == 0
  prime_nums = []
  i = 2
  while prime_nums.length < count
    prime_nums << i if is_prime?(i)
    i += 1
  end
  prime_nums
end

# the "calls itself recursively" spec may say that there is no method
# named "and_call_original" if you are using an older version of
# rspec. You may ignore this failure.
# Also, be aware that the first factorial number is 0!, which is defined
# to equal 1. So the 2nd factorial is 1!, the 3rd factorial is 2!, etc.
def factorials_rec(num)
  # return [1] if num <= 0
  return [1] if num <= 1
  factorial = factorial(num)
  factorials_rec(num-1) + [factorial(num)]

end

def factorial(num)
  return 1 if num <= 1
  (num - 1) * factorial(num-1)
end

# 1! = 1
#2! = 1*1
# 3! = 3*2*1*1 => 6
# 4! = 4*3*2*1*1 => 24
# 5! = 5*

class Array
  def dups
  end
end

class String
  def symmetric_substrings
    result = []
    self.substrings.each do |string|
      result << string if string.palindrome?
    end
    result
  end

  def substrings
    results = []
    self.length.times do |i|
      (i+1).upto(self.length-1) do |j|
        results << self[i..j]
      end
    end
    results
  end


  def palindrome?
    center = self.length/2
    result = true
    self[0...center].split("").each_with_index do |letter, i|
      result = false unless letter == self[-1-i]
    end
    result
  end
end

class Array
  def merge_sort(&prc)
    return self if self.length <= 1
    prc ||= Proc.new{|num1, num2| num1 <=> num2 }
    center = self.length/2
    left = self[0...center].merge_sort(&prc)
    puts "gave #{self[0...center]}, got #{left}."
    right= self[center..-1].merge_sort(&prc)
    puts "gave #{self[center..-1]}, got #{right}."

    sorted = []
    while true
      if right.empty?
        return sorted += left
      elsif left.empty?
        return sorted += right
      else
        if prc.call(right.first, left.first) == -1
          sorted << right.shift
        else
          sorted << left.shift
        end
      end
    end
  end

  private
  def self.merge(left, right, &prc)
  end
end
