class Api::V1::AppsController < Api::V1::BaseController
  def create
    if service.create
      render_message("App created")
    end
  end

  def destroy
    if service.destroy
      render_message("App deleted")
    end
  end

  def rename
    if service.rename(app_params[:new_name])
      render_message("App renamed")
    end
  end

  def urls
    render_json({ urls: service.urls })
  end

  def deploy
    if deploy_worker
      render_message("App deployed")
    end
  end

  private

    def service
      @_service ||= AppsService.new(app_name)
    end

    def deploy_worker
      @_deploy_worker ||= DeploymentWorker.new(clone_url: app_params[:clone_url], app_name: app_name, branch: app_params[:branch]).perform
    end

    def app_params
      params.require(:app).permit(:name, :new_name, :clone_url, :branch)
    end
end
