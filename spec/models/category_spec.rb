require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should have_many(:nominations).dependent(:destroy) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }
end
