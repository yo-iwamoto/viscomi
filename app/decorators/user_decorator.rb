# frozen_string_literal: true

module UserDecorator
  def initial
    name[0].upcase
  end
end
