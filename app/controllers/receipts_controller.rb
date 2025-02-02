require 'json'
class ReceiptsController < ApplicationController
    def create 
        receipt = Receipt.create(receipt_params)
        # i = itemize(receipt)
        # binding.pry
        render json: ReceiptSerializer.format(receipt)
    end 
    
    private 
    
    def receipt_params
        params.require(:receipt).permit(:retailer, :purchaseDate, :purchaseTime, :total, :items => [:shortDescription, :price])
    end
    
    # def itemize(receipt)
    #     items = []
    #     receipt.items.each do |item|
    #         sub = item.gsub! " =>", ":"
    #         items << JSON.parse(sub)
    #     end 
    #     items
    # end 
end 