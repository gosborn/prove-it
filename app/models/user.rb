class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_many :notifications
  has_many :votes
  has_many :user_challenges
  has_many :challenges, through: :user_challenges
  has_many :evidences

  def competing?(challenge)
    challenge.users.include?(self)
  end

  def voted?(challenge)
    challenge.votes.where(recipient_id: self.id).exists?
  end

end
