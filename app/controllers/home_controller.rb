class HomeController < ApplicationController
  skip_before_action :authenticate_request_using_x_auth_token!
  def index
    render json: { message: "Well, there is nothing for you here! But we are Up!", status: 200 }
  end
end
