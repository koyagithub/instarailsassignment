class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :picture, presence: true
  validates :user_id, presence: true
  validate  :picture_size
  
    private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "5MB以上のファイルはアップロードできません")
      end
    end
end
