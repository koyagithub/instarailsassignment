class User < ApplicationRecord
  authenticates_with_sorcery!

  #default scope order desc
  default_scope -> { order(created_at: :desc) }
  
  #Password validation
  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  #Username validation
  validates :username, presence: true, uniqueness: true, length: { maximum: 16 }
  
  #E-mail validation
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
                    
  #Profile validation
  validates :profile, presence: true, length: { maximum: 140 }, allow_nil:  true
  
  #name validation
  validates :name, presence: true, length: { maximum: 30 }
  
  #phone_num validation
  validates :phone_num, length: { maximum: 30}, allow_nil:  true
  
  #gender validation
  validates :gender, length: { maximum: 10}, allow_nil:  true
  
  #web validation
  validates :web, length: { maximum: 120}, allow_nil:  true
  
  #Related with Micropost and Like model
  has_many :microposts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_stories, through: :likes, source: :micropost
  
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

  # Return status feed of the user
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end
  
  # Follow user
  def follow(other_user)
    following << other_user
  end

  # Unfollow user
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Return true if the user is following other_user
  def following?(other_user)
    following.include?(other_user)
  end
end
