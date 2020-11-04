class AddHasToPayColumnToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :has_to_pay, :int
  end
end
