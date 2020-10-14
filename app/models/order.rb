class Order < ApplicationRecord
    attribute :is_active, :boolean, default: true
    attribute :completed, :boolean, default: false
    belongs_to :project
    has_many :apartments
    has_many :parkings 
    has_one :client
    has_one :user

    validates :contract_start_date, presence: true, length:{maximum: 15}
    validates :contract_end_date, presence: true, length:{maximum: 15}
    validates :payment_type, presence: true, length:{maximum: 30}
    validates :in_advance_payment, presence: true
end
