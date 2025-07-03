# frozen_string_literal: true

class AppsService < BaseService
  def initialize(app_name)
    super(app_name)
  end

  def create
    execute_dokku_command("apps:create #{app_name}")
  end

  def rename(new_app_name)
    execute_dokku_command("apps:rename #{app_name} #{new_app_name}")
  end

  def destroy
    execute_dokku_command("apps:destroy --force #{app_name}")
  end

  def urls
    result = execute_dokku_command("urls #{app_name}")
    result.split("\n")
  end
end
