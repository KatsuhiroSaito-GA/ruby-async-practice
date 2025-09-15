module Sidekiq
  class SampleJob
    include Sidekiq::Worker

    def perform(params)
      pp params
    end
  end
end
