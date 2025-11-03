class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { regular: 0, admin: 1 }, default: :regular

  has_many :recipes, dependent: :destroy
end
