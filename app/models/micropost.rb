class Micropost < ApplicationRecord
  #Relate with user model
  belongs_to :user
  
  #Relate with like and comment model
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  
  #Validation
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 20 }, allow_nil: true
  validate  :picture_size
  
  #Search method
  def self.search(search) #Self.means Micropost.
    if search
      where(['content LIKE ?', "%#{search}%"]) #Display partial match of content。
    else
      all #Display all
    end
  end
    
    private

    # Validates the size of uploaded picture
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "5MB以上のファイルはアップロードできません")
      end
    end
end
