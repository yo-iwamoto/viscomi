# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdDecorator do
  let(:ad) { Ad.new.extend AdDecorator }
  subject { ad }
  it { should be_a Ad }
end
