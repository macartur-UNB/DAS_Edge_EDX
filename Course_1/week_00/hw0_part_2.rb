def hello name
   return "Hello,#{name}" 
end

def starts_with_consonant? s
	if s.nil? or s.length == 0 or 
		return false
	end

	if s[0].downcase() < 'a' and s[0].downcase() > 'z' 
		return false
	end

    vowels = ["A", "E", "I", "O", "U"]
    vowels.each do |letter|
        if letter == s[0].upcase()
            return false
        end
    end
    return true
end

def binary_multiple_of_4? s
    return false
end
