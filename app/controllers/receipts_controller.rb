require "json"
class ReceiptsController < ApplicationController
    def create
        receipt = Receipt.create(receipt_params)
        render json: ReceiptSerializer.format(receipt)
    end

    def index
        receipt = Receipt.find(params[:id])
        render json: ReceiptSerializer.show_total(receipt)
    end

    private

    def receipt_params
        params.require(:receipt).permit(:retailer, :purchaseDate, :purchaseTime, :total, items: [ :shortDescription, :price ])
    end
end
