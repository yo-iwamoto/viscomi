require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end

  describe 'validation' do
    it 'should be valid' do
      expect(@user).to be_valid
    end
  end
end
