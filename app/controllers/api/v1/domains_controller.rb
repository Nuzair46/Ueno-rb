class Api::V1::DomainsController < Api::V1::BaseController
  def add
    if service.add(app_params[:domain])
      render_message("Domain added")
    end
  end

  def remove
    if service.remove(app_params[:domain])
      render_message("Domain removed")
    end
  end

  private

    def service
      @_service ||= DomainsService.new(app_name)
    end

    def app_params
      params.require(:app).permit(:name, :domain)
    end
end
