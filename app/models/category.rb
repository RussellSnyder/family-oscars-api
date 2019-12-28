class Category < ApplicationRecord
  # model association
  has_many :nominations, dependent: :destroy

  # validations
  validates_presence_of :title, :created_by
end
