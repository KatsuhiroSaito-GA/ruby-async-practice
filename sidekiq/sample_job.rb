module Sidekiq
  class SampleJob
    include Sidekiq::Job

    def perform(params)
      pp params
    end
  end
end
