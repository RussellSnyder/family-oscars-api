class Vote < ApplicationRecord
  # model association
  belongs_to :nomination
  # validation
  validates_presence_of :created_by, :nomination_id
end
