require_relative 'configuration'

params = { 'name' => 'bar' }
Sidekiq::SampleJob.perform_async(params)

puts "Sidekiq job enqueued with params: #{params}"
