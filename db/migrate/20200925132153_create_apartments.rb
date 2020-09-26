class CreateApartments < ActiveRecord::Migration[6.0]
  def change
    create_table :apartments do |t|
      t.integer :block
      t.integer :number
      t.integer :space
      t.integer :price
      t.boolean :is_sold
      t.boolean :reserved

      t.timestamps
    end
  end
end
