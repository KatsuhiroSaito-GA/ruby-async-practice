require 'active_job'
require_relative '../sidekiq/configuration'
require_relative 'sample_job'

ActiveJob::Base.queue_adapter = :sidekiq
