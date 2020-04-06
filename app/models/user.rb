class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

#=========================自分がフォローしている(active)(following)ユーザーを集める==========================================
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  #フォローする側(active)(following)から見て、フォローされる側(passive)(follower)のユーザーを、中間テーブルを介して集める。
  #なので親(foreign_key)はfollowing_id(フォローする側)

  has_many :followings, through: :active_relationships, source: :follower
  #中間テーブル（active_relationships）を介して、「follower」モデルのUser(フォローされた側)を集めることを「following」と定義。
#======================================================================================================================

#=========================自分をフォローしている(passive)(follower)ユーザーを集める==========================================
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id

  has_many :followers, through: :passive_relationships, source: :following
#======================================================================================================================

  attachment :profile_image

  validates :name, presence: true
  validates :name, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

  def followed_by?(user)
    # 今自分(引数のuser)がフォローしようとしているユーザー(レシーバー)がフォローされているユーザー(つまりpassive)の中から、
    #引数に渡されたユーザー(自分)がいるかどうかを調べる
    passive_relationships.find_by(following_id: user.id).present?
  end

  def self.search_start(search)
    User.where(['name LIKE(?)', "#{search}%"])
  end

  def self.search_back(search)
    User.where(['name LIKE(?)', "%#{search}"])
  end

  def self.search_part(search)
    User.where(['name LIKE(?)', "%#{search}%"])
  end


end
