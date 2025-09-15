require_relative 'configuration'

params = { 'message' => 'Hello Sidekiq!' }
SidekiqPractice::SampleJob.perform_async(params)

puts "Sidekiq job enqueued with params: #{params}"
