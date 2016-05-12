require "byebug"

def range(start_num, end_num)
  return [] if end_num <= start_num + 1
  range(start_num, end_num - 1) + [end_num - 1]
end

def range_it(start_num, end_num)
  output = []
  ((start_num+1)...end_num).each do |number|
    output << number
  end
  output
end

def array_sum(array)
  return 0 if array.empty?
  return array.first if array.length == 1
  array.pop + array_sum(array)
end

def array_sum_it(array)
  return 0 if array.empty?
  array.inject{ |sum, num| sum + num}
end

def exp(base, n)
  return 1 if n == 0
  base * exp(base, n-1)
end

def exp2(base, n)
  return 1 if n == 0
  return base if n == 1

  if n % 2 == 0
    temp = exp2(base, n / 2)
    temp * temp
  else
    temp = exp2(base, (n-1) / 2)
    base * temp * temp
  end
end

class Array
  def deep_dup
    #base case
    return [] if self.empty?

    if self.first.is_a?(Array)
      [self.first.deep_dup] + self[1..-1].deep_dup
    else #base case: when 'self' is not an Array.
      [self.first] + self[1..-1].deep_dup
    end
  end

end

def fibonacci(n)
  return [0] if n == 0
  return [0, 1] if n ==1
  temp = fibonacci(n-1)
  temp << (temp[-1] + temp [-2])
end

def bsearch(array, num)
  center = array.length/2
  #debugger
  if array[center].nil?
    nil
  elsif array[center] == num
    center
  elsif array[center] > num
    bsearch(array[0...center], num)
  else
    ret = bsearch(array[(center+1)..-1], num)
    return nil if ret.nil?
    ret + center + 1
  end
end

def merge_sort(array)
  return array if array.length <= 1

  center = array.length / 2

  arr1 = merge_sort(array[0...center])
  arr2 = merge_sort(array[center..-1])

  sorted_arr = []
  while true
    if arr1.empty?
      return sorted_arr += arr2
    elsif arr2.empty?
      return sorted_arr += arr1
    else
      if arr1.first > arr2.first
        sorted_arr << arr2.shift
      else
        sorted_arr << arr1.shift
      end
    end
  end

end

def subsets(array)
  return [[]] if array.empty?
  last = array.pop
  new_array = subsets(array)
  new_array + new_array.map{|n| n + [last] }
end


# def make_change(amount, coins = [25, 10, 5, 1])
#   return [] if amount == 0
#   coin_array = []
#   coins.each do |coin|
#     if (amount - coin) >= 0
#       return coin_array = [coin] + make_change(amount - coin)
#     end
#   end
#
# end

def make_change(amount, coins = [25, 10, 5, 1])
  return [] if amount == 0
  coin_array = nil
  coins.each_with_index do |coin, i|
    if (amount - coin) >= 0
      next_change = make_change(amount - coin, coins[i..-1])
      next unless next_change
      potential_coins = [coin] + next_change
      coin_array ||= potential_coins
      if coin_array.length > potential_coins.length
        coin_array = potential_coins
      end
    end
  end
  coin_array
end



  # coins.shift
  # if coins.length > 0
  #   coin_array2 = make_change(amount, coins)
  #   if coin_array2.length < coin_array.length
  #     return coin_array2
  #   else
  #     return coin_array
  #   end
  # else
  #   return coin_array
  # end



# def make_change(amount, coins = [25, 10, 5, 1])
#
#   coins.map do |i|
#     coins = coins[i..-1]
#     return [] if amount == 0
#     coin_array = []
#     unless coins.nil?
#       coins.each do |coin|
#         if (amount - coin) >= 0
#            [coin] + make_change(amount - coin)
#         end
#       end
#     end
#
#   end
# end

# def make_change(amount, coins = [25, 10, 5, 1])
#   return [] if amount == 0
#
#   master_coin_array = []
#   coins.length.times do |i|
#     coin_array = []
#     coins.each do |coin|
#       if (amount - coin) >= 0
#         master_coin_array << coin_array = [coin] + make_change(amount - coin)
#         break
#       end
#     end
#   end
#   return master_coin_array
# end
