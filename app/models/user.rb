class User < ActiveRecord::Base
  def profile_thumb_image
    profile_image.url(:thumb)
  end

  attr_accessible :name, :description, :admin, :address, :email, :phone, :password, :password_confirmation, :profile_image

  has_secure_password

  has_many :tweets, order: "created_at desc"
  mount_uploader :profile_image, ProfileImageUploader

  has_many :favorites
  has_many :favorite_tweets, :through => :favorites, :source => :tweet

  has_one :design_image

  has_and_belongs_to_many :followings,
                          :class_name => 'User',
                          :join_table => 'users_have_followings',
                          :foreign_key => 'user_id',
                          :association_foreign_key => 'following_id',
                          :uniq => true
  # has_many :follow_as_follower, foreign_key: 'user_id', class_name: 'Follow'
  # has_many :follow_as_following, foreign_key: 'following_id', class_name: 'Follow'

  # has_many :followers, through: :follow_as_follower
  # has_many :followings, through: :follow_as_following
  # # has_many  :followings,
  #           :through => :followings,
  #           :source => :user

  has_and_belongs_to_many :followers,
                          :class_name => 'User',
                          :join_table => 'users_have_followings',
                          :foreign_key => 'following_id',
                          :association_foreign_key => 'user_id',
                          :uniq => true

  validates :name, :uniqueness => true
  validates :name, :presence => true
  validates :name, :length => {:minimum => 4, :maximum =>40}
  validates :name, :format => { :with => /^[a-zA-Z0-9_]+$/,
    :message => "Only letters and digit and underbar allowed" }

  validates :phone, :format => { :with => /^[0-9]{3,}\-[0-9]{3,}\-[0-9]{4,}$/ }

  validates :email, :format => { :with => /^[a-zA-Z0-9_]+\@[a-zA-Z0-9_]+\.[a-zA-Z0-9_]+.[a-zA-Z0-9_]*$/ }

  validates :password, :presence => true, on: :create
  validates :password, :length => {:minimum => 6, :maximum =>12}, on: :create
  # validate :check_following_in_my_id

  # def check_following_in_my_id
  #   if self.followings.include? self
  #     errors.add(:followings, "Cannot follow me")
  #   end
  # end

  def me_and_followings
    self.followings+[self]
  end

  def add_to_favorites(tweet)
    favorite_tweets << tweet
  end

  def self.search(search)
    if search
      where("name like ?", "%#{search}%")
    end
  end
end
