class Api::V1::ConfigsController < Api::V1::BaseController
  def set
    if service.set(key_values: key_values_params)
      render_message("Config set")
    end
  end

  def unset
    if service.unset(keys: app_params[:keys])
      render_message("Config unset")
    end
  end

  private

    def service
      @_service ||= ConfigsService.new(app_name)
    end

    def key_values_params
      params[:app][:key_values]&.map(&:permit!)
    end

    def app_params
      params.require(:app).permit(:name, :restart, keys: [])
    end
end
