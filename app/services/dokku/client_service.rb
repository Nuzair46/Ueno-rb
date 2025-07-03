# frozen_string_literal: true

require "net/ssh"

class Dokku::ClientService
  attr_reader :command, :as_root, :username, :port, :key_data, :dokku_ssh_host_name

  def initialize(command, as_root = false)
    @command = command
    @as_root = as_root
    @username = as_root ? "ubuntu" : "dokku"
    @port = 22
    @key_data = [ Settings.dokku.ssh_private_key ]
    @dokku_ssh_host_name = Settings.dokku.ssh_host_name
  end

  def execute_command
    begin
      Net::SSH.start(dokku_ssh_host_name, username, port:, key_data:) do |ssh|
        output = ssh.exec!(command)

        if output && !output.empty?
          return [ true, output.strip ]
        else
          return [ false, "Command execution failed or returned empty output" ]
        end
      end
    rescue StandardError => e
      [ false, e.message ]
    end
  end
end
