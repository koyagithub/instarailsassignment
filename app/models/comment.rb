class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validates :body , presence: true, length: { maximum: 100 }
  validates :user_id , presence: true
  

end
