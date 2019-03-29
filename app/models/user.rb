class User < ApplicationRecord
  has_many :ideas
  has_many :reviews

  has_secure_password

  validates :email, presence: true,
                    uniqueness: true,
                    format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :first_name, presence: true

  validates :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}".strip
  end
end
