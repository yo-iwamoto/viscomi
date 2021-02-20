# frozen_string_literal: true

module CommunityCenterDecorator
  def followers_number
    followers.count
  end
end
