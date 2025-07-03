# frozen_string_literal: true

class DomainsService < BaseService
  attr_reader :app_name

  def initialize(app_name)
    super(app_name)
  end

  def add(domain)
    execute_dokku_command("domains:add #{app_name} #{domain}")
  end

  def remove(domain)
    execute_dokku_command("domains:remove #{app_name} #{domain}")
  end
end
