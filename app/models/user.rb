class User < ApplicationRecord
  authenticates_with_sorcery!

  #Password validation
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  #Username validation
  validates :username, uniqueness: true, length: { maximum: 16 }
  
  #E-mail validation
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
                    
  #Profile validation
  validates :profile, presence: true, length: { maximum: 140 }, allow_nil:  true
  
  #Related with Micropost model
  has_many :microposts, dependent: :destroy
  
  #Authentications has-many and dependent
  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications
  
  #Relationship
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy                                  
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  # Follow user
  def follow(other_user)
    following << other_user
  end

  # Unfollow user
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Return true if assigned user is following other_user
  def following?(other_user)
    following.include?(other_user)
  end
end
