class User < ApplicationRecord
  # encrypt password
  has_secure_password

  # Model associations
  has_many :votes, foreign_key: :created_by
  has_many :categories, foreign_key: :created_by
  has_many :nominations, foreign_key: :created_by
  # Validations
  validates_presence_of :name, :email, :password_digest
end
