# frozen_string_literal: true

module ContactDecorator
  def sent_at_formatted
    sent_at&.strftime("%m月 %d日")
  end

  def updated_at_formatted
    updated_at&.strftime("%m月 %d日")
  end

  def image
    contact_image&.image
  end
end
