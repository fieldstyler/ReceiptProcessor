class Receipt < ApplicationRecord
    def itemize
        items = []
        self.items.each do |item|
            sub = item.gsub! " =>", ":"
            items << JSON.parse(sub)
        end 
        calculate_total(items)
    end 

    private

    def calculate_total(items)
        @total = 0
        calc_retailer_length(self.retailer)
        check_total_value(self.total)
        item_count(items.size)
        calc_description_length(items)
        check_day(self.purchaseDate)
        check_time(self.purchaseTime)
        @total
    end 

    def calc_retailer_length(retailer)
        # couldn't find a working alphanumeric regex
        chars_array = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
        chars = []
        retailer.chars.each do |char|
            chars << char if chars_array.include?(char)
        end 
        @total += chars.count
    end 
    
    def check_total_value(total)
        cents = total[-2..-1].to_i
        if cents == 0
            @total += 75
        elsif cents % 25 == 0
            @total += 25
        end
    end 
    
    def item_count(total)
        @total += 5 * (total / 2)
    end 
    
    def calc_description_length(items)
        items.each do |item|
            if item["shortDescription"].strip.size % 3 == 0
                @total += calc_item(item)
            end 
        end 
    end 

    def calc_item(item)
        float = item["price"].to_f * 0.2 
        float == float.to_i ? float : float.to_i + 1
    end
    
    def check_day(date)
        date[-2..-1].to_i % 2 == 0 ? nil : @total += 6
    end 
    
    def check_time(time)
        if time[0..1].to_i >= 14 && time[0..1].to_i < 16
            if time[0..1].to_i == 14 && time[-2..-1].to_i == 0
            else
                @total += 10
            end 
        end 
    end 
end
