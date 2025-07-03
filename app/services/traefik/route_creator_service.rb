class Traefik::RouteCreatorService
  attr_reader :app_name, :url, :file_name, :template, :domain

  def initialize(app_name, url)
    @app_name = app_name
    @url = url
    @template = File.read(Rails.root.join("traefik", "route-template.yml"))
    @file_name = Rails.root.join("traefik", "dynamic", "#{app_name}.yml")
    @domain = Settings.domain
  end

  def create_file!
    File.open(file_name, "w") do |file|
      file.write(route_yaml)
    end
  end

  private

    def route_yaml
      erb = ERB.new(template)
      erb.result_with_hash(app_name:, url:, domain:)
    end
end
