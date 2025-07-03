# frozen_string_literal: true

class Api::V1::BaseController < ApplicationController
  private

    def app_name
      app_params[:name]
    end
end
