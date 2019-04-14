# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
    rescue_from ActiveRecord::RecordInvalid, with: :bad_request_error
    rescue_from ActionController::UnpermittedParameters, with: :bad_request_error
  end

  private

  def not_found_error(error)
    json_response({ errors: [title: error.class.name, detail: error.message] }, :not_found)
  end

  def bad_request_error(error)
    json_response({ errors: [title: error.class.name, detail: error.message] }, :bad_request)
  end
end
