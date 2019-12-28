class Nomination < ApplicationRecord
  # model association
  belongs_to :category
  has_many :votes, dependent: :destroy

  # validation
  validates_presence_of :title, :created_by
end
