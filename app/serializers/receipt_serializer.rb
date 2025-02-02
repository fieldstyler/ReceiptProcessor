class ReceiptSerializer
    def self.format(receipt)
        { "id" => receipt.id.to_s }
    end

    def self.show_total(receipt)
        { "points" => receipt.itemize }
    end
end
