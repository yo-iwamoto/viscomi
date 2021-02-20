# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommunityCenterDecorator do
  let(:community_center) { CommunityCenter.new.extend CommunityCenterDecorator }
  subject { community_center }
  it { should be_a CommunityCenter }
end
