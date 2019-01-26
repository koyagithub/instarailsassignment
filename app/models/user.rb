class User < ApplicationRecord
  authenticates_with_sorcery!

  #password validation
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  #uesrname validation
  validates :username, uniqueness: true, length: { maximum: 16 }
  
  #e-mail validation
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
                    
  #profile validation
  validates :profile, presence: true, length: { maximum: 140 }, allow_nil:  true
  
  #related with Micropost model
  has_many :microposts, dependent: :destroy
  
  #has-many and dependent
  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications
end
