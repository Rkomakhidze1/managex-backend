class AddFieldsToProject < ActiveRecord::Migration[6.0]
  def change
    change_column :projects, :apartment_spaces, :decimal, precision: 12, scale: 2
    change_column :projects, :parking_spaces, :decimal, precision: 12, scale: 2
    change_column :projects, :budget, :decimal, precision: 12, scale: 2
    change_column :projects, :income_expected, :decimal, precision: 12, scale: 2
  end
end
