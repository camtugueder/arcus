# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role, type: :model do
  # Association tests
  describe 'associations' do
    it { should have_and_belong_to_many(:users) }
    it { should belong_to(:resource).optional }
  end

  # Validation tests
  describe 'validations' do
    it { should validate_inclusion_of(:resource_type).in_array(Rolify.resource_types).allow_nil }
  end

end