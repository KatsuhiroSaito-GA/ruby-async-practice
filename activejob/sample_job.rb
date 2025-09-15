class SampleJob < ActiveJob::Base
  queue_as :default

  def perform(params)
    pp params
  end
end
