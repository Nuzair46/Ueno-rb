# frozen_string_literal: true

class BaseWorker
  include Sidekiq::Worker

  sidekiq_options queue: "default", retry: 5
end
