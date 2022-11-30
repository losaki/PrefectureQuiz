# frozen_string_literal: true

class FlashMessageComponent < ViewComponent::Base
  def initialize(type:, data:)
    @type = type
    @data = data
    @color = alert_color(type)
  end

  private 

  def alert_color(type)
    case type
    when "success"
      "bg-green-100 border-green-500 text-green-700"
    when "error"
      "bg-orange-100 border-orange-500 text-orange-700"
    when "notice"
      "bg-yellow-100 border-yellow-500 text-yellow-700"
    else
      "bg-blue-100 border-blue-500 text-blue-700"
    end
  end

end
