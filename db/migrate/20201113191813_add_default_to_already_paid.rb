class AddDefaultToAlreadyPaid < ActiveRecord::Migration[6.0]
  def change
    change_column :projects, :already_paid, :decimal, precision: 12, scale: 2, default: 0
  end
end
