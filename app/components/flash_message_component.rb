# frozen_string_literal: true

class FlashMessageComponent < ViewComponent::Base
  def initialize(type:, data:)
    @type = type
    @data = data
  end

end
