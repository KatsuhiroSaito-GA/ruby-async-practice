module Sidekiq
  class SampleJob
    include Sidekiq::Worker
    sidekiq_options queue: 'default'

    def perform(params)
      pp params
    end
  end
end
