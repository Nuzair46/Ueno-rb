
class DeploymentWorker < BaseWorker
  attr_reader :clone_url, :app_name, :branch

  def initialize(clone_url:, app_name:, branch:)
    @clone_url = clone_url
    @app_name = app_name
    @branch = branch
  end

  def perform
    service = Dokku::DeployService.new(clone_url:, app_name:, branch:)
    if service.deploy!
      urls = AppsService.new(app_name).urls
      Traefik::RouteCreatorService.new(app_name, urls.first).create_file!
    end
  end
end
