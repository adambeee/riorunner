class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  validates_presence_of :first_name, :last_name, :phone
  validates :phone, length: {minimum: 7, maximum: 10}

  before_save :uppercase_fields

  def uppercase_fields
    self.first_name.capitalize!
    self.last_name.capitalize!
  end
  def last_initial
    self.last_name[0,1].capitalize
  end
  def first_initial
    self.first_name[0,1].capitalize
  end
  has_many :tasks, :foreign_key => "wallet_id", dependent: :destroy
  has_many :messages, :foreign_key => "recipient_id"
  has_many :reviews
  has_many :authentications, dependent: :destroy

#for omniauth

  def apply_omniauth(omniauth)

    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'], :oauth_token => omniauth['credentials']['token'], :oauth_expires_at => omniauth['credentials']['expires_at'])
    self.email = omniauth['info']['email'] if email.blank?
    self.first_name = omniauth['info']['first_name'] if first_name.blank?
    self.last_name = omniauth['info']['last_name'] if last_name.blank?
    self.image_url = omniauth['info']['image'] if image_url.blank?
    self.username = omniauth['info']['nickname'] if username.blank?

  end
end
