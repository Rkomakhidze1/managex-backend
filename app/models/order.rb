class Order < ApplicationRecord
    attribute :is_active, :boolean, default: true
    attribute :completed, :boolean, default: false
    belongs_to :project
    has_many :apartments
    has_many :parkings 
    has_one :client
    has_one :user
end
