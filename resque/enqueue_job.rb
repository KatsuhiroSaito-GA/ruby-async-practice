require_relative 'configuration'

params = { 'message' => 'Hello Resque!' }
Resque.enqueue(Resque::SampleJob, params)

puts "Resque job enqueued with params: #{params}"
