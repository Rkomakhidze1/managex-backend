class AddPaymentDatesToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :payment_dates, :json, default: []
  end
end
