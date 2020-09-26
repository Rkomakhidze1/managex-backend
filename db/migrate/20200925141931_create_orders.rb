class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.date :contract_start_date
      t.date :contract_end_date
      t.boolean :is_active
      t.boolean :completed
      t.string :payment_type
      t.integer :in_advance_payment
      t.integer :apartment_space_sum
      t.integer :parking_space_sum
      t.integer :apartment_price_sum
      t.integer :parking_price_sum
      t.integer :full_price_sum
      t.integer :user_id
      t.integer :client_id

      t.timestamps
    end
  end
end
