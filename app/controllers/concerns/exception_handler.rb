# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
    rescue_from ActiveRecord::RecordInvalid, with: :bad_request_error
  end

  private

  def not_found_error(e)
    json_response({ error: e.message }, :not_found)
  end

  def bad_request_error(e)
    json_response({ error: e.message }, :bad_request)
  end
end
