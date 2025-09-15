require 'active_job'
require_relative '../resque/configuration'
require_relative 'sample_job'

# ActiveJobのqueue_adapterをSidekiqに設定
ActiveJob::Base.queue_adapter = :resque
