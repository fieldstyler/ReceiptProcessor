class CreateReceipts < ActiveRecord::Migration[8.0]
  def change
    create_table :receipts do |t|
      t.string :retailer
      t.string :purchaseDate
      t.string :purchaseTime
      t.string :total
      t.string :items, array: true, default: []

      t.timestamps
    end
    add_index :receipts, :items, using: 'gin'
  end
end
