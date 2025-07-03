# frozen_string_literal: true

def enable_test_coverage
  require "simplecov"
  require "pry"

  SimpleCov.start do
    add_filter "/test/"

    add_group "Controllers", "app/controllers"
    add_group "Helpers", "app/helpers"
    add_group "Workers", "app/workers"
    add_group "Services", "app/services"
  end
end

enable_test_coverage if ENV["COVERAGE"]

ENV["RAILS_ENV"] ||= "test"

require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/ci"
require "minitest/autorun"
require "mocha/minitest"


Minitest::Ci.report_dir = "reports" if ENV["CI"]

class ActiveSupport::TestCase
  include ActionView::Helpers::TranslationHelper
  parallelize(workers: :number_of_processors)
end

class BaseTest < ActionDispatch::IntegrationTest
  def before_setup
    super
    DokkuClientServiceMock.mock_execute_command([ true, "mocked result" ])
  end
end

module DokkuClientServiceMock
  def self.mock_execute_command(return_value)
    Dokku::ClientService.any_instance.stubs(:execute_command).returns(return_value)
  end
end

def headers(options = {})
  {
    "X-Auth-Token" => Settings.ueno_token
  }.merge(options)
end

def response_body
  response.parsed_body
end
