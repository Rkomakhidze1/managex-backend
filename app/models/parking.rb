class Parking < ApplicationRecord
    attribute :is_sold, :boolean, default: false
    attribute :reserved, :boolean, default: false
    belongs_to :project
    has_one :order
    has_one :client
end
