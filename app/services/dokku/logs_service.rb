# frozen_string_literal: true

require "net/http"

class Dokku::LogsService
  attr_reader :app_identifier, :domain, :uri, :ueno_token, :log_type

  def initialize(app_identifier, log_type = "build")
    @app_identifier = app_identifier
    @log_type = log_type
    @domain = Settings.domain
    @uri = URI.parse("#{domain}/api/v1/deployments/logs")
    @ueno_token = Settings.ueno_token
  end

  def send_log_to_domain(log_line)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == "https"

    request = Net::HTTP::Post.new(uri.request_uri, "Content-Type" => "application/json", "X-Auth-Token" => ueno_token)
    payload = { log: { app_identifier:, log_line:, log_type: } }.to_json

    http.request(request, payload)
  end
end
