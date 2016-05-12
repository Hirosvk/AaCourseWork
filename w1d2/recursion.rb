def quick_sort(arr)
  return arr if arr.length <= 1
  control = arr.shift
  arr1 = []
  arr2 = []
  arr.each { |el| el < control ? arr1 << el : arr2 << el }
  quick_sort(arr1) + [control] + quick_sort(arr2)
end

def sum_to(n)
  if n < 0
    return nil
  elsif n <= 1
    return 1
  else
    n + sum_to(n-1)
  end
end

def add_numbers(array = nil)
  return nil if array.nil?
  return array.first if array.length <= 1
  array.shift + add_numbers(array)
end

def gamma_fnc(n)
  return 1 if n <= 1
  (n-1) * gamma_fnc(n-1)
end
