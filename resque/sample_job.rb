module Resque
  class SampleJob
    @queue = :default

    def self.perform(params)
      pp params
    end
  end
end
