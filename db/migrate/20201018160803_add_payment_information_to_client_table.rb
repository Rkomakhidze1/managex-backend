class AddPaymentInformationToClientTable < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :payment_schedule, :int, {default: [], array: true}
    add_column :clients, :full_payment, :int
    add_column :clients, :already_paid, :int
  end
end
