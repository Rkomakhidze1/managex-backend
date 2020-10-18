class Client < ApplicationRecord
    belongs_to :company
    has_many :apartments
    has_many :parkings
    has_many :orders
    has_many :payment_schedules

    validates :id_number, presence: true, uniqueness: true, length: {minimum:11, maximim:11}
    validates :name, presence: true, length:{minimum:2, maximum:20}
    validates :surname, presence: true, length:{minimum:2, maximum:40}
    validates :phone_number, uniqueness: true, length: {maximum:13}
end
