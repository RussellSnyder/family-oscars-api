require 'rails_helper'

RSpec.describe Nomination, type: :model do
  it { should belong_to(:category) }
  it { should have_many(:votes).dependent(:destroy) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }
end
