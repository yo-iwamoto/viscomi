# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContactDecorator do
  let(:contact) { Contact.new.extend ContactDecorator }
  subject { contact }
  it { should be_a Contact }
end
