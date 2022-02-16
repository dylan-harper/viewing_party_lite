class User < ApplicationRecord

  has_secure_password

  validates_presence_of :name,
                        :email,
                        :password_digest

  validates_uniqueness_of :email

  has_many :user_parties
  has_many :parties, through: :user_parties

  def invites
    parties
      .where('user_parties.status = ?', 'Invited')
  end

  def hosting
    parties
      .where('user_parties.status = ?', 'Host')
  end
end
