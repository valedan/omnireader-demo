# frozen_string_literal: true

module Helpers
  module Requests
    def json_response
      JSON.parse(response.body, symbolize_names: true, object_class: OpenStruct)
    end
  end
end
