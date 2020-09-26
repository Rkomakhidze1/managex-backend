class User < ApplicationRecord
    belongs_to :company
    has_many :orders
    has_secure_password
end
