# frozen_string_literal: true

module ApiRescuable
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::ParameterMissing, with: :handle_api_error
    rescue_from BaseService::DokkuCommandFailedError, with: :handle_dokku_error
  end

  private

    def handle_api_error(exception)
      log_exception(exception)
      render_error(exception.original_message, :internal_server_error)
    end

    def handle_dokku_error(exception)
      log_exception(exception)
      render_error(exception.message, :internal_server_error)
    end
end
