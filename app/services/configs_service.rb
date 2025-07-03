# frozen_string_literal: true

class ConfigsService < BaseService
  attr_reader :restart_command

  def initialize(app_name)
    @restart_command = "--no-restart"
    super(app_name)
  end

  def set(key_values: [ {} ])
    dokku_key_format = ""
    key_values.each do |key_set|
      key_set.each do |key, value|
        dokku_key_format += "#{key}=#{value} "
      end
    end
    execute_dokku_command("config:set #{restart_command} #{app_name} #{dokku_key_format}")
  end

  def unset(keys: [])
    dokku_key_format = keys.join(" ")
    execute_dokku_command("config:unset #{restart_command} #{app_name} #{dokku_key_format}")
  end
end
