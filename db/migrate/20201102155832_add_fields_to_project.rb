class AddFieldsToProject < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :apartment_spaces, :decimal, precision: 8, scale: 2
    add_column :projects, :parking_spaces, :decimal, precision: 8, scale: 2
    add_column :projects, :budget, :decimal, precision: 8, scale: 2
    add_column :projects, :income_expected, :decimal, precision: 8, scale: 2
  end
end
