class Api::V1::ProcsController < Api::V1::BaseController
  def rebuild
    if service.rebuild
      render_message("App rebuild in progress")
    end
  end

  def report
    render_json({ report: service.report })
  end

  def restart
    if service.restart
      render_message("App restart in progress")
    end
  end

  def scale
    if service.scale(app_params[:process_type], app_params[:quantity])
      render_message("App scaled")
    end
  end

  def start
    if service.start
      render_message("App started")
    end
  end

  def stop
    if service.stop
      render_message("App stopped")
    end
  end

  private

    def service
      @_service ||= ProcsService.new(app_name)
    end

    def app_params
      params.require(:app).permit(:name, :process_type, :quantity)
    end
end
