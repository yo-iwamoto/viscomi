# frozen_string_literal: true

module AdDecorator
  def image
    ad_image&.image
  end
end
