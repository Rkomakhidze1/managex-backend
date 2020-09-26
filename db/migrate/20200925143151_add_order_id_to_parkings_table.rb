class AddOrderIdToParkingsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :parkings, :order_id, :int
  end
end
