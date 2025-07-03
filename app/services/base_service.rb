# frozen_string_literal: true

class BaseService
  attr_reader :app_name

  class DokkuCommandFailedError < StandardError; end

  def initialize(app_name)
    @app_name = app_name
  end

  def self.call(*args)
    new(*args).call
  end

  def execute_dokku_command(command, as_root: false)
    success, result = Dokku::ClientService.new(command, as_root).execute_command
    raise DokkuCommandFailedError.new(result) unless success
    result
  end
end
