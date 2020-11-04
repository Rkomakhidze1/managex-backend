class ChangeIntegerFieldToFoats < ActiveRecord::Migration[6.0]
  def change
    change_column :apartments, :block, :string
    change_column :apartments, :number, :string
    change_column :apartments, :space, :decimal, precision: 8, scale: 2
    change_column :apartments, :price, :decimal, precision: 8, scale: 2

    change_column :clients, :full_payment, :decimal, precision: 8, scale: 2
    change_column :clients, :already_paid, :decimal, precision: 8, scale: 2
    change_column :clients, :has_to_pay, :decimal, precision: 8, scale: 2

    change_column :orders, :in_advance_payment, :decimal, precision: 8, scale: 2
    change_column :orders, :apartment_space_sum, :decimal, precision: 8, scale: 2
    change_column :orders, :parking_space_sum, :decimal, precision: 8, scale: 2
    change_column :orders, :apartment_price_sum, :decimal, precision: 8, scale: 2
    change_column :orders, :parking_price_sum, :decimal, precision: 8, scale: 2
    change_column :orders, :full_price_sum, :decimal, precision: 8, scale: 2

    change_column :parkings, :block, :string
    change_column :parkings, :number, :string
    change_column :parkings, :space, :decimal, precision: 8, scale: 2
    change_column :parkings, :price, :decimal, precision: 8, scale: 2
  end
end
