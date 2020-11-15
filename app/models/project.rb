class Project < ApplicationRecord
    has_many :apartments, dependent: :destroy
    has_many :parkings, dependent: :destroy
    has_many :orders
    has_many :clients

    attribute :already_paid, :decimal, default: 0
end
