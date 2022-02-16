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

  def self.invalid_length?(password)
    password.length < 8
  end

  def self.invalid_characters?(password)
    special = "?<>',?[]}{=-)(*&^%$#`~{}/"
    specials = special.split('')
    characters = password.split('')
    characters.each do |c|
      specials.each do |s|
        if c == s
          return true
        end
      end
    end
    false
  end
end
