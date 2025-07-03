class ApplicationController < ActionController::API
  include Authenticatable
  include ApiRescuable
  include ApiResponders
  include Loggable
end
