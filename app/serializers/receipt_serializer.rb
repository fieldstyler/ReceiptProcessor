class ReceiptSerializer
    def self.format(receipt)
        { "id" => receipt.id.to_s }
    end 
end 