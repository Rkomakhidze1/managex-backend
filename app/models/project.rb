class Project < ApplicationRecord
    belongs_to :company
    has_many :apartments, dependent: :destroy
    has_many :parkings, dependent: :destroy
    has_many :orders
end
