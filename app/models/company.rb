class Company < ApplicationRecord
    has_many :projects, dependent: :destroy
    has_many :users, dependent: :destroy
    has_many :clients, dependent: :destroy
end
