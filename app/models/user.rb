class User < ApplicationRecord
  has_many :user_parties
  has_many :parties, through: :user_parties

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true

  has_secure_password

  def self.other_users(id)
    where.not(id:)
  end

  def invitations
    parties.joins(:user_parties).where("user_parties.is_host = false")
  end

  def parties_hosting
    parties.joins(:user_parties).where("user_parties.is_host = true")
  end
end
