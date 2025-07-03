# frozen_string_literal: true

module Authenticatable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request_using_x_auth_token!
  end

  def authenticate_request_using_x_auth_token!
    token = request.headers["X-Auth-Token"].presence
    ueno_token = Settings.ueno_token

    if ActiveSupport::SecurityUtils.secure_compare(token, ueno_token)
      true
    else
      render_error("Api Token Invalid", :unauthorized)
    end
  end
end
