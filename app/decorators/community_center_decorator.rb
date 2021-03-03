# frozen_string_literal: true

module CommunityCenterDecorator
  def followers_number
    followers.count
  end

  def image
    community_center_image&.image
  end
end
