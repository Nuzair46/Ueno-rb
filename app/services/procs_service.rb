# frozen_string_literal: true

class ProcsService < BaseService
  def initialize(app_name)
    super(app_name)
  end

  def rebuild
    execute_dokku_command("ps:rebuild #{app_name}")
  end

  def restart
    execute_dokku_command("ps:restart #{app_name}")
  end

  def start
    execute_dokku_command("ps:start #{app_name}")
  end

  def stop
    execute_dokku_command("ps:stop #{app_name}")
  end

  def scale(process_type, quantity)
    execute_dokku_command("ps:scale #{app_name} #{process_type}=#{quantity}")
  end

  def report
    output = execute_dokku_command("ps:report #{app_name} ")
    report_sanitizer(output)
  end

  private

    def report_sanitizer(output)
      sanitized_output = {}

      output.each_line do |line|
        next if line.strip.empty?
        next if line.include?("=====>")

        key, value = line.split(":", 2).map(&:strip)

        sanitized_output[key.parameterize] = value
      end
      sanitized_output
    end
end
