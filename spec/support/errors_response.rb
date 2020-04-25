# frozen_string_literal: true

module ErrorsResponse
  def match_json_error(key)
    parsed_body = JSON.parse(response.body)
    parsed_body.dig("errors", "detail", key)
  end
end

RSpec.configure do |config|
  config.include(ErrorsResponse)
end
