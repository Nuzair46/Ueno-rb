# frozen_string_literal: true

class LogsService < BaseService
  def initialize(app_name)
    super(app_name)
  end

  def logs
    # TODO: Implement this method
    # execute_dokku_command("logs #{app_name}")
  end
end
