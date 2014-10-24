class BookInStock 
    attr_accessor :isbn , :price
        
    def initialize isbn,price
       
        if isbn.empty? or price <= 0
            raise ArgumentError.new('the isbn is empty or price is bellow or egual to zero')
        end
        
        @isbn = isbn
        @price = price

        def price_as_string  
            return "$%.2f"  % @price
        end
    end
end
