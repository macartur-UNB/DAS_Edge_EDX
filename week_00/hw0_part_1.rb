def sum  array
   if array.length == 0  or array.nil?
    return 0
   else
      sum = 0
      array.each  do |element|
          sum += element
      end
        return sum
   end
end

def max_2_sum array
    if array.length == 0  or array.nil?
        return 0
    elsif array.length ==  1
        return array[0]
    else
        array.sort! 
        return (array[array.length - 1] ) + ( array[array.length - 2])
    end
    
end

def sum_to_n? array,n 
    if array.length <=1 or array.nil?
       return false 
    end
    
    array.each do |first|    
        array.each do |second|
            if  first != second and first + second == n
               return true 
            end
        end
    end
    return false
end

#------------------------------------------
array = []
puts "array empty"
puts sum array

array = [2]
puts "array with 1 element"
puts sum array

array = [1,2,3,4]
puts "array with 4 elements"
puts sum array
#-------------------------------------------



#------------------------------------------
array = []
puts "array empty"
puts max_2_sum array

array = [2]
puts "array with 1 element"
puts max_2_sum array

array = [1,2,3,4]
puts "array with 4 elements"
puts max_2_sum array
#-------------------------------------------


#------------------------------------------
array = []
puts "array empty"
puts sum_to_n? array,4

array = [2]
puts "array with 1 element"
puts sum_to_n? array,2

array = [1,2,3,4]
puts "array with 4 elements"
puts sum_to_n? array ,4
#-------------------------------------------
