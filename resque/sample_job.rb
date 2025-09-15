module ResquePractice
  class SampleJob
    @queue = :default

    def self.perform(params)
      pp params
    end
  end
end
