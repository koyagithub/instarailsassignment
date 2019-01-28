class Micropost < ApplicationRecord
  #Relate with user model
  belongs_to :user
  
  #Relate with like model
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  
  #Validation
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validate  :picture_size
  

    private

    # Validates the size of uploaded picture
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "5MB以上のファイルはアップロードできません")
      end
    end
end
