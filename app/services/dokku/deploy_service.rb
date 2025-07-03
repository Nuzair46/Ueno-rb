# frozen_string_literal: true

class Dokku::DeployService
  attr_reader :clone_url, :target_dir, :app_name, :branch, :dokku_ssh_private_key, :dokku_ssh_host_name

  def initialize(clone_url:, app_name:, branch:)
    @clone_url = clone_url
    @app_name = app_name
    @branch = branch
    @target_dir = Rails.root.join("tmp", "repositories", app_name)
    @dokku_ssh_host_name = Settings.dokku.ssh_host_name
    @dokku_ssh_private_key = Settings.dokku.ssh_private_key
  end

  def deploy!
    status = clone_repository! && add_brand_remote! && push_to_dokku!
    cleanup_tmp_dir!
    status
  end

  private

    def push_to_dokku!
      Dir.chdir(target_dir) do
        push_and_log
      end
    end

    def clone_repository!
      system("git clone -b #{branch} #{clone_url} #{target_dir}")
    end

    def add_brand_remote!
      Dir.chdir(target_dir) do
        system("git remote add brand dokku@#{dokku_ssh_host_name}:#{app_name}")
      end
    end

    def cleanup_tmp_dir!
      system("rm -rf #{target_dir}")
    end

    def write_private_key
      File.write("/tmp/id_rsa", dokku_ssh_private_key)
      File.chmod(0600, "/tmp/id_rsa")
    end

    def git_ssh_command
      write_private_key
      "ssh -i /tmp/id_rsa -o StrictHostKeyChecking=no -o IdentitiesOnly=yes"
    end

    def push_and_log
      IO.popen("GIT_SSH_COMMAND='#{git_ssh_command}' git push brand #{branch} 2>&1") do |io|
        io.each do |line|
          logs_service.send_log_to_domain(line)
        end
      end
    end

    def logs_service
      @logs_service ||= Dokku::LogsService.new(app_name)
    end
end
