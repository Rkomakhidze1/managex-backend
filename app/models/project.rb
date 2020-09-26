class Project < ApplicationRecord
    belongs_to :company
    has_many :apartments
    has_many :parkings
    has_many :orders
end
