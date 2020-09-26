class AddSecretToCompaniesTable < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :secret, :string
  end
end
