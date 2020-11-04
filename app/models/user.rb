class User < ApplicationRecord
    belongs_to :company
    has_many :orders
    has_secure_password

    validates :username, presence: true,  
                            uniqueness: {case_sensitive: false}, 
                            length:{minimum:3, maximum:30}



end
