# frozen_string_literal: true

module PostDecorator
  def formatted_date
    created_at.strftime("%m月 %d日")
  end

  def image
    post_image&.image
  end
end
