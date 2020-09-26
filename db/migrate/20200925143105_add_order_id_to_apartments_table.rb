class AddOrderIdToApartmentsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :apartments, :order_id, :int
  end
end
