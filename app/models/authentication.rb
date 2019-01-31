class Authentication < ApplicationRecord
    belongs_to :user
    validate :user_id
end
